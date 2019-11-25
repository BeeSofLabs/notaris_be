# == Schema Information
#
# Table name: orders
#
#  id                     :bigint(8)        not null, primary key
#  agunan_pokok           :integer
#  angsuran_bunga         :integer
#  document_type          :string
#  is_deleted             :boolean          default(FALSE)
#  jangka_waktu           :string
#  no_perjanjian          :string
#  no_request_order       :integer
#  plafond                :integer
#  status                 :integer
#  tgl_akad               :string
#  tgl_jatuh_tempo        :string
#  total_price            :integer
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

	belongs_to :creator, class_name: "User", foreign_key: :user_id, optional: true
	belongs_to :debtor, class_name: "User", foreign_key: :debtor_id, optional: true
	belongs_to :creditor, class_name: "User", foreign_key: :creditor_id, optional: true
	belongs_to :collateral_owner, class_name: "User", foreign_key: :collateral_owner_id, optional: true
	belongs_to :notary, class_name: "User", foreign_key: :notary_id, optional: true
	

	has_and_belongs_to_many :immovable_collaterals
	has_and_belongs_to_many :movable_collaterals

	enum :document_type => { "fidusia": "fidusia", "skmht": "skmht", "apht": "apht", "skmht_apht": "skmht_apht" }
	# enum :status => ["cancelled", "pending", "completed", "expired"	]
	enum :status => ["draft", "cancel", "sign", "waiting_payment", "payment_done", "claim", "completed", "expired"]

	before_create :assign_default_value


	def self.create_order_with_movable_collateral(user, params, movable_collateral_ids)
		ActiveRecord::Base.transaction do
			order = self.create(params)
			if order.try(:id).present?
				order.update(tgl_jatuh_tempo: Time.now + 24.hours, 
					user_id: user.id, 
					valid_expired_datetime: DateTime.now + 1.days,
					movable_collaterals: MovableCollateral.find(movable_collateral_ids))
			end
			order
		end
	end

	def self.create_order_with_immovable_collateral(user, params, immovable_collateral_ids)
		ActiveRecord::Base.transaction do
			order = self.create(params)
			if order.try(:id).present?
				no_request_order = params[:no_request_order].present? ? params[:no_request_order] : Time.now.to_i
				order.update(tgl_jatuh_tempo: Time.now + 24.hours, 
					user_id: user.id, 
					no_request_order: no_request_order,	
					valid_expired_datetime: DateTime.now + 1.days,
					immovable_collaterals: ImmovableCollateral.find(immovable_collateral_ids))
			end
			order
		end
	end

	private

		def assign_default_value
			self.status = "draft"
		end

end
