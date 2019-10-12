# == Schema Information
#
# Table name: orders
#
#  id           :bigint(8)        not null, primary key
#  expired_date :datetime
#  grand_total  :integer
#  order_type   :integer
#  status       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  notary_id    :integer
#  user_id      :integer
#
# Indexes
#
#  index_orders_on_notary_id  (notary_id)
#  index_orders_on_user_id    (user_id)
#

class OrderSerializer < ActiveModel::Serializer
  attributes 	:id,
				:grand_total,
				:order_type,
				:status,
				:created_at,
				:updated_at,
				:notary_id,
				:user_id
  has_one :fidusia_order
end