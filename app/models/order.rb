# == Schema Information
#
# Table name: orders
#
#  id                     :bigint(8)        not null, primary key
#  agunan_pokok           :integer
#  angsuran_bunga         :integer
#  document_type          :string
#  grand_total            :integer
#  is_deleted             :boolean          default(FALSE)
#  jangka_waktu           :string
#  no_perjanjian          :string
#  order_type             :integer
#  plafond                :integer
#  status                 :integer
#  tgl_akad               :string
#  tgl_jatuh_tempo        :string
#  valid_expired_datetime :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  collateral_owner_id    :bigint(8)
#  debtor_id              :bigint(8)
#  notary_id              :integer
#  user_id                :integer
#
# Indexes
#
#  index_orders_on_collateral_owner_id  (collateral_owner_id)
#  index_orders_on_debtor_id            (debtor_id)
#  index_orders_on_notary_id            (notary_id)
#  index_orders_on_user_id              (user_id)
#

class Order < ApplicationRecord
	# has_many :fidusia_collaterals, dependent: :nullify
	# has_many :skmht_collaterals, dependent: :nullify
	# has_many :apht_collaterals, dependent: :nullify
	# has_many :collaterals

	# belongs_to :collateral, polymorphic: true

	belongs_to :notary, class_name: "User", foreign_key: :notary_id, optional: true
	belongs_to :creditor, class_name: "User", foreign_key: :user_id, optional: true
	belongs_to :collateral_owner, class_name: "User", foreign_key: :collateral_owner_id, optional: true
	belongs_to :debtor, class_name: "User", foreign_key: :debtor_id, optional: true

  has_many :collateral_orders, dependent: :nullify
  # has_many :collaterals, through: :collateral_orders, source: :collateral
  has_many :movable_collaterals, through: :collateral_orders, source: :collateral, source_type: 'MovableCollateral'
  has_many :immovable_collaterals, through: :collateral_orders, source: :collateral, source_type: 'ImmovableCollateral'

	# accepts_nested_attributes_for :fidusia_collaterals
	# accepts_nested_attributes_for :skmht_collaterals
	# accepts_nested_attributes_for :apht_collaterals


	enum :document_type => { "fidusia": "fidusia", "skmht": "skmht", "apht": "apht", "skmht_apht": "skmht_apht" }
	enum :status => ["cancelled", "pending", "completed", "expired"]

	before_create :assign_default_value

	def self.create_order(user, params, notary_service)
    ActiveRecord::Base.transaction do
      order = self.create(params[:header])
      if order.try(:id).present?
        order.update(tgl_jatuh_tempo: Time.now + 24.hours, grand_total: notary_service.price, user_id: user.id)
        collateral = order.document_type.eql?("fidusia") ? MovableCollateral.create(params[:movable_collaterals]) : ImmovableCollateral.create(params[:immovable_collaterals])

        collateral.collateral_orders.create(order_id: order.id) if collateral.try(:id).present?
      end
      order
    end
  end

	# def self.parent_order(current_user, opts)
	# 	Order.create!(
	# 		order_type: opts[:order_type],
	# 		expired_date: Time.now + 24.hours,
	# 		notary_id: opts[:notary_id],
	# 		grand_total: opts[:notary_service_price],
	# 		user_id: current_user.id
	# 	)
	# end

	private

		def assign_default_value
			self.status = "pending"
		end

end
