# == Schema Information
#
# Table name: orders
#
#  id                     :bigint(8)        not null, primary key
#  agunan_pokok           :integer
#  angsuran_bunga         :integer
#  collateral_type        :string
#  document_type          :string
#  is_deleted             :boolean          default(FALSE)
#  jangka_waktu           :string
#  no_perjanjian          :string
#  plafond                :integer
#  status                 :integer
#  tgl_akad               :string
#  tgl_jatuh_tempo        :string
#  valid_expired_datetime :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  collateral_id          :integer
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
	has_many :fidusia_collaterals, dependent: :nullify
	has_many :skmht_collaterals, dependent: :nullify
	has_many :apht_collaterals, dependent: :nullify
	# has_many :collaterals
  	belongs_to :notary, class_name: "User", foreign_key: :notary_id, optional: true
  	belongs_to :creditor, class_name: "User", foreign_key: :user_id, optional: true
  	belongs_to :collateral_owner, class_name: "User", foreign_key: :collateral_owner_id, optional: true
	belongs_to :debtor, class_name: "User", foreign_key: :debtor_id, optional: true

	accepts_nested_attributes_for :fidusia_collaterals
	accepts_nested_attributes_for :skmht_collaterals
	accepts_nested_attributes_for :apht_collaterals


	enum :document_type => ["fidusia", "skmht", "apht", "skmht_apht"]
	enum :status => ["cancelled", "pending", "completed", "expired"]

	before_create :assign_default_status

	def self.fidusia_order(current_user, opts, fidusia_params, collateral_params)
		ActiveRecord::Base.transaction do
			order = parent_order(current_user, opts)
			order.create_fidusia_order!(fidusia_params)
			order.collaterals.create!(collateral_params)
			return order
		end
	end

	def self.skmht_order(current_user, opts, skmht_params, collateral_params)
		ActiveRecord::Base.transaction do
			order = parent_order(current_user, opts)
			order.create_skmht_order!(skmht_params)
			order.collaterals.create!(collateral_params)
			return order
		end
	end

	def self.apht_order(current_user, opts, apht_params, collateral_params)
		ActiveRecord::Base.transaction do
			order = parent_order(current_user, opts)
			order.create_apht_order!(apht_params)
			order.collaterals.create!(collateral_params)
			return order
		end
	end

	def self.parent_order(current_user, opts)
		Order.create!(
			order_type: opts[:order_type],
			expired_date: Time.now + 24.hours,
			notary_id: opts[:notary_id],
			grand_total: opts[:notary_service_price],
			user_id: current_user.id
		)
	end

	private

		def assign_default_status
			self.status = "pending"
		end

end
