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

class OrderSerializer < ActiveModel::Serializer
  	attributes 	:id,
				:grand_total,
				:document_type,
				:status,
				:created_at,
				:updated_at,
				:notary_id,
				:user_id

  	has_many :collaterals
end
