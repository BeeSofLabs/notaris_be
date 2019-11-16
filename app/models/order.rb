# == Schema Information
#
# Table name: orders
#
#  id                     :bigint(8)        not null, primary key
#  delete                 :boolean          default(FALSE)
#  grand_total            :integer
#  order_type             :integer
#  status                 :integer
#  valid_expired_datetime :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  notary_id              :integer
#  user_id                :integer
#
# Indexes
#
#  index_orders_on_notary_id  (notary_id)
#  index_orders_on_user_id    (user_id)
#

class Order < ApplicationRecord
	has_one :fidusia_order
	has_one :skmht_order
	has_one :apht_order
	has_many :collaterals
	belongs_to :notary, class_name: "User", foreign_key: :notary_id

	enum :order_type => ["fidusia", "skmht", "apht", "skmht_apht"]
	enum :status => ["cancelled", "pending", "completed", "expired"]

	after_create :assign_default_status

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
