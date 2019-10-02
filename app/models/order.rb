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
	has_many :collaterals

	enum :order_type => ["fidusia", "skmht", "apht", "skmht and apht"]
end
