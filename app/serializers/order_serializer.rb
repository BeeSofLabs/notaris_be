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

class OrderSerializer < ActiveModel::Serializer
  	attributes 	:id,
				:grand_total,
				:order_type,
				:status,
				:created_at,
				:updated_at,
				:notary_id,
				:user_id,
				:skmht_order,
				:apth_order,
				:fidusia_order


  	has_many :collaterals
end
