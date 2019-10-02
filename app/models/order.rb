# == Schema Information
#
# Table name: orders
#
#  id             :bigint(8)        not null, primary key
#  grand_total    :integer
#  order_type     :integer
#  orderable_type :string
#  status         :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  orderable_id   :bigint(8)
#
# Indexes
#
#  index_orders_on_orderable_type_and_orderable_id  (orderable_type,orderable_id)
#

class Order < ApplicationRecord
	has_one :fidusia_order
	has_one :skmht_order

	enum :order_type => ["fidusia", "skmht", "apht", "skmht and apht"]
end
