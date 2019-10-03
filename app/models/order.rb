# == Schema Information
#
# Table name: orders
#
#  id          :bigint(8)        not null, primary key
#  grand_total :integer
#  order_type  :integer
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  notary_id   :integer
#  user_id     :integer
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

	enum :order_type => ["fidusia", "skmht", "apht", "skmht and apht"]
	enum :status => ["cancelled", "pending", "completed", "expired"]

	after_create :assign_default_status


	private

		def assign_default_status
			self.status = "pending" if self.status.blank?
		end
end
