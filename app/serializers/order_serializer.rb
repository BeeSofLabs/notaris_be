# == Schema Information
#
# Table name: orders
#
#  id                     :bigint(8)        not null, primary key
#  agunan_pokok           :integer
#  angsuran_bunga         :integer
#  doc_filename           :string
#  doc_token_privy        :string
#  document_type          :string
#  has_creditor_signed    :boolean          default(FALSE)
#  has_debtor_signed      :boolean          default(FALSE)
#  has_pa_signed          :boolean          default(FALSE)
#  html_content           :string           default("")
#  is_deleted             :boolean          default(FALSE)
#  jangka_waktu           :string
#  no_order               :string
#  no_perjanjian          :string
#  no_request_order       :string
#  plafond                :integer
#  status                 :integer
#  tgl_akad               :string
#  tgl_jatuh_tempo        :string
#  total_price            :integer
#  url_document_privy     :string
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
	  attributes :id,
	  			:no_request_order,
				:no_perjanjian,
				:plafond,
				:tgl_akad,
				:tgl_jatuh_tempo,
				:tarif_bunga,
				:jangka_waktu,
				:agunan_pokok,
				:angsuran_bunga, 
				:document_type,
				:url_document_privy,
				:doc_token_privy,
				:doc_filename,
				:has_pa_signed,
				:has_creditor_signed,
				:has_debtor_signed,
				:status,
				:created_at,
				:updated_at,
				:notary_user,
				:debtor_user,
				:creditor_user,
				:collateral_user

	# has_many :collaterals
	has_many :immovable_collaterals  
	has_many :movable_collaterals  
	has_one :chat_room
	
	def notary_user
		NotarySerializer.new(object.notary)
	end

	def debtor_user
		DebtorSerializer.new(object.debtor)
	end

	def creditor_user
		CreditorSerializer.new(object.creditor)
	end

	def collateral_user
		CollateralSerializer.new(object.collateral_owner)
	end

end
