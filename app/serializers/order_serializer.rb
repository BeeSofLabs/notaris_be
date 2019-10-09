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
