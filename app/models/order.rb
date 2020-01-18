# == Schema Information
#
# Table name: orders
#
#  id                     :bigint(8)        not null, primary key
#  agunan_pokok           :integer
#  angsuran_bunga         :integer
#  doc_filename           :string
#  doc_token_privy        :string
#  document_type          :string
#  has_creditor_signed    :boolean          default(FALSE)
#  has_debtor_signed      :boolean          default(FALSE)
#  has_pa_signed          :boolean          default(FALSE)
#  html_content           :string           default("")
#  is_deleted             :boolean          default(FALSE)
#  jangka_waktu           :string
#  no_order               :string
#  no_perjanjian          :string
#  no_request_order       :string
#  plafond                :integer
#  status                 :integer
#  tgl_akad               :string
#  tgl_jatuh_tempo        :string
#  total_price            :integer
#  url_document_privy     :string
#  valid_expired_datetime :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  collateral_owner_id    :bigint(8)
#  creditor_id            :bigint(8)
#  debtor_id              :bigint(8)
#  notary_id              :integer
#  user_id                :integer
#
# Indexes
#
#  index_orders_on_collateral_owner_id  (collateral_owner_id)
#  index_orders_on_creditor_id          (creditor_id)
#  index_orders_on_debtor_id            (debtor_id)
#  index_orders_on_notary_id            (notary_id)
#  index_orders_on_user_id              (user_id)
#

class Order < ApplicationRecord
  attr_accessor :chat_room_id

	belongs_to :creator, class_name: "User", foreign_key: :user_id, optional: true
	belongs_to :debtor, class_name: "User", foreign_key: :debtor_id, optional: true
	belongs_to :creditor, class_name: "User", foreign_key: :creditor_id, optional: true
	belongs_to :collateral_owner, class_name: "User", foreign_key: :collateral_owner_id, optional: true
	belongs_to :notary, class_name: "User", foreign_key: :notary_id, optional: true

	has_many :collateral_orders, dependent: :nullify
	# has_many :collaterals, through: :collateral_orders, source: :collateral
	has_many :movable_collaterals, through: :collateral_orders, source: :collateral, source_type: 'MovableCollateral'
	has_many :immovable_collaterals, through: :collateral_orders, source: :collateral, source_type: 'ImmovableCollateral'

	# accepts_nested_attributes_for :fidusia_collaterals
	# accepts_nested_attributes_for :skmht_collaterals
	# accepts_nested_attributes_for :apht_collaterals

	has_one :chat_room, dependent: :nullify
	has_many :chats, through: :chat_room


	has_and_belongs_to_many :immovable_collaterals
	has_and_belongs_to_many :movable_collaterals

	enum :document_type => { "fidusia": "fidusia", "skmht": "skmht", "apht": "apht", "skmht_apht": "skmht_apht" }

	enum :status => {"draft":0, "submission": 1, "revision": 2, "approval":3, "paid":4, "partial": 5,
	"claim":6, "expired":9,  "cancel":10, "deleted": 11,"done": 20, "completed": 21}

	before_create :assign_default_value
  	after_create :create_chat_room, :if => :allow_chat_room?

	def allow_chat_room?
		self.document_type != "skmht"
	end

	def self.create_order_with_movable_collateral(user, params, order_id, movable_collateral_ids)
		ActiveRecord::Base.transaction do

			unless Order.exists?(order_id)
				order = self.create(params)
				order.update(
					status: Order.statuses[params[:status]],
					tgl_jatuh_tempo: Time.now + 24.hours,
					user_id: user.id,
					valid_expired_datetime: DateTime.now + 1.days,
					movable_collaterals: MovableCollateral.find(movable_collateral_ids),
					no_request_order: "RO-#{Time.now.to_i}")
			else
				order = Order.find(order_id)
				order.update(params)
			end

			order
		end
	end

	def self.create_order_with_immovable_collateral(user, params, order_id, immovable_collateral_ids)
		ActiveRecord::Base.transaction do

			unless Order.exists?(order_id)
				order = self.create(params)
				no_request_order = params[:no_request_order].present? ? params[:no_request_order] : "RO-#{Time.now.to_i}"
				order.update(
					status: Order.statuses[params[:status]],
					tgl_jatuh_tempo: Time.now + 24.hours,
					user_id: user.id,
					no_request_order: no_request_order,
					valid_expired_datetime: DateTime.now + 1.days,
					immovable_collaterals: ImmovableCollateral.find(immovable_collateral_ids))
			else
				order = Order.find(order_id)
				order.update(params)
			end

			order
			Notification.build("notif_submission", user.id, "Order Dokument anda telah dibuat")
		end
	end


	def self.build_file(order_id)

        order = Order.find order_id

        if order.present? && order.html_content.present?
            filename = "#{order.document_type}-#{order.id}"
            save_path = Rails.root.join(ENV['ROOT_DIRECTORY_DOC_PDF'], "#{filename}.pdf")
            Html2Pdf.generate(order.html_content, save_path)

			order.update(doc_filename: filename)
            return save_path
        end

        nil
    end

  def chat_room_id
    @chat_room_id = self.chat_room.try(:id)
  end

  def check_status(order_status)
    new_order_object = Order.find_by(id: self.id)
    Rails.logger.info "========== self order object: #{self.inspect}"
    Rails.logger.info "========== new order object: #{new_order_object.inspect}"
    Rails.logger.info "========== status is #{order_status} : #{new_order_object.status.eql?(order_status)}"

    if new_order_object.present?
      new_order_object.update(is_deleted: true) if new_order_object.status.eql?('submission') && order_status.eql?('submission')
      new_order_object.update(status: 'done') if new_order_object.status.eql?('claim') && order_status.eql?('claim') && new_order_object.chats.count < 1
    end
  end

  def self.to_csv(orders)
    attributes = %w{ agunan_pokok angsuran_bunga doc_filename doc_token_privy document_type has_creditor_signed has_debtor_signed has_pa_signed html_content is_deleted jangka_waktu no_order no_perjanjian no_request_order plafond status tgl_akad tgl_jatuh_tempo total_price url_document_privy valid_expired_datetime created_at updated_at collateral_owner_id creditor_id debtor_id notary_id user_id}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      orders.each do |order|
        csv << attributes.map{ |attr| order.send(attr) }
      end
    end
  end

	private
		def assign_default_value
			self.status = "draft"
		end

    def create_chat_room
      ChatRoom.create(open_date: Date.today, order_id: self.id)
    end

end
