# == Schema Information
#
# Table name: users
#
#  id                         :bigint(8)        not null, primary key
#  address                    :string
#  address_bpn                :string
#  address_companion          :string
#  address_in_idcard_bpn      :string
#  address_ppat               :string
#  approved                   :boolean          default(FALSE)
#  bank_account_notaris       :string
#  bank_name                  :string
#  bank_name_ppat             :string
#  city                       :string
#  district                   :string
#  dob                        :string
#  email                      :string
#  fax                        :string
#  fax_ppat                   :string
#  gender                     :string
#  gender_companion           :string
#  idcard_number_companion    :string
#  identity_image             :string
#  identity_number            :string
#  komparisi                  :text
#  komparisi_companion        :text
#  komparisi_ppat             :text
#  lat                        :float
#  lat_companion              :float
#  lat_ppat                   :float
#  lng                        :float
#  lng_companion              :float
#  lng_ppat                   :float
#  mother_bpn                 :string
#  name                       :string
#  name_companion             :string
#  name_organization          :string
#  name_ppat                  :string
#  no_akta                    :string
#  no_akta_ppat               :string
#  no_rekening_ppat           :string
#  no_sk_notaris              :string
#  no_sk_notaris_ppat         :string
#  occupation                 :string
#  office_address             :string
#  organizational_status      :integer          default("perorangan")
#  password_digest            :string
#  phone                      :string
#  pob                        :string
#  privy_token                :string
#  province                   :string
#  reset_password_sent_at     :datetime
#  reset_password_token       :string
#  selfie_image               :string
#  status_companion           :string
#  tgl_akta                   :string
#  tgl_akta_ppat              :string
#  tgl_sk_notaris             :string
#  tgl_sk_ppat                :string
#  user_tipe                  :integer
#  valid_count_search_notaris :integer          default(0)
#  village                    :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  indonesia_city_id          :integer
#  indonesia_village_id       :integer
#

class UserSerializer < ActiveModel::Serializer
	attributes	:id,
				:approved,
				:dob,
				:email,
				:gender,
				:identity_image,
				:identity_number,
				:name,
				:organizational_status,
				:phone,
				:identity_number,
				:privy_token,
				:user_tipe,
				:lat,
				:lng
				
	has_many 	:notary_services, if: :notaris?

	def notaris?
		object.has_role?(:notaris)
	end
end
