# == Schema Information
#
# Table name: users
#
#  id                         :bigint(8)        not null, primary key
#  active                     :boolean          default(TRUE)
#  address                    :string
#  address_bpn                :string
#  address_companion          :string
#  address_in_idcard_bpn      :string
#  address_ppat               :string
#  apht_price                 :decimal(, )      default(0.0)
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
#  fidusia_price              :decimal(, )      default(0.0)
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
#  privy_status               :string
#  privy_token                :string
#  province                   :string
#  reset_password_sent_at     :datetime
#  reset_password_token       :string
#  selfie_image               :string
#  skmht_price                :decimal(, )      default(0.0)
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
#  privy_id                   :string
#

class UserSerializer < ActiveModel::Serializer
	attributes	:id, :approved, :dob, :email, :gender, :identity_image, :identity_number, :name, :organizational_status, :phone, :identity_number, :privy_token, :user_tipe, :lat, :lng, :active, :indonesia_village, :indonesia_district, :indonesia_city, :indonesia_province, :address, :address_bpn, :address_companion, :address_in_idcard_bpn, :address_ppat, :fax, :fax_ppat, :no_akta, :no_akta_ppat, :no_sk_notaris, :no_sk_notaris_ppat, :tgl_akta, :tgl_akta_ppat, :tgl_sk_notaris, :tgl_sk_ppat, :price_min, :price_max

	has_many 	:notary_services, if: :notaris?

	def notaris?
		object.has_role?(:notaris)
	end

  def price_min
    object.has_role?(:notaris) ? object.notary_services.minimum(:price) : 0
  end

  def price_max
    object.has_role?(:notaris) ? object.notary_services.maximum(:price) : ""
  end
end
