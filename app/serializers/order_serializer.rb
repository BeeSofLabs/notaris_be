# == Schema Information
#
# Table name: orders
#
#  id                     :bigint(8)        not null, primary key
#  agunan_pokok           :integer
#  angsuran_bunga         :integer
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
