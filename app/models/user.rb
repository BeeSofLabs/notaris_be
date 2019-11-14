# == Schema Information
#
# Table name: users
#
#  id                      :bigint(8)        not null, primary key
#  address                 :string
#  address_bpn             :string
#  address_companion       :string
#  address_in_idcard_bpn   :string
#  address_ppat            :string
#  approved                :boolean          default(FALSE)
#  bank_account_notaris    :string
#  bank_name               :string
#  bank_name_ppat          :string
#  city                    :string
#  district                :string
#  dob                     :date
#  email                   :string
#  fax                     :string
#  gender                  :string(1)
#  gender_companion        :string(1)
#  idcard_number_companion :string
#  identity_image          :string
#  identity_number         :string
#  komparisi               :text
#  komparisi_companion     :text
#  komparisi_ppat          :text
#  lat                     :float
#  lat_companion           :float
#  lat_ppat                :float
#  lng                     :float
#  lng_companion           :float
#  lng_ppat                :float
#  mother_bpn              :string
#  name                    :string
#  name_companion          :string
#  name_organization       :string
#  name_ppat               :string
#  no_akta                 :string
#  no_akta_ppat            :string
#  no_fak_ppat             :string
#  no_rekening_ppat        :string
#  no_sk_notaris           :string
#  no_sk_notaris_ppat      :string
#  occupation              :string
#  office_address          :string
#  organizational_status   :integer          default("perorangan")
#  password_digest         :string
#  phone                   :string
#  privy_token             :string
#  province                :string
#  reset_password_sent_at  :datetime
#  reset_password_token    :string
#  selfie_image            :string
#  status_companion        :string
#  tgl_akta                :date
#  tgl_akta_ppat           :date
#  tgl_sk_notaris          :date
#  tgl_sk_ppat             :date
#  user_tipe               :integer
#  village                 :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  indonesia_city_id       :integer
#

class User < ApplicationRecord
	rolify
	# encrypt password}
	has_secure_password

	# Validations
	validates_presence_of :name, :email, :phone, :password_digest
	validates_uniqueness_of :email
	validates_uniqueness_of :phone

	enum organizational_status: ["perorangan", "perusahaan"]
	enum gender: ["laki-laki", "perempuan"]
	enum user_tipe: ["notaris", "debitur", "kreditur","collateral_owner", "bpn"] 

	mount_base64_uploader :identity_image, ImageUploader
	mount_base64_uploader :selfie_image, ImageUploader

	has_many :orders
	has_many :notary_services
	has_one :indonesia_city

	def insert_privy_token(privy_token)
		update!(privy_token: privy_token)
	end

	def privy_approved
		update!(approved: true)
	end

	def image_content(image)
		Rails.env.production? ? "#{image.path}" : "#{image.path}" 
	end

	def self.roles
		%w(notaris
		debitur
		kreditur
		collateral_owner
		)
	end

	def self.notaris
		user = User.with_role("notaris")
	end

	def generate_password_token!
		self.reset_password_token	= generate_token
		self.reset_password_sent_at	= Time.now
		save!	
	end

	def valid_reset_password_token?
		self.reset_password_sent_at + 4.hours > Time.now
	end

	def reset_password!(new_password)
		self.reset_password_token = nil
		self.password = new_password
		save!
	end

	def set_user_role(role)
		case role
		when "notaris"
			self.add_role(:notaris)
		when "debitur"
			self.add_role(:debitur)
		when "kreditur"
			self.add_role(:kreditur)
		when "collateral_owner"
			self.add_role(:collateral_owner)
		when "bpn"
			self.add_role(:bpn)
		else
			self.add_role(:user)
		end
	end

	private 

		def generate_token
			SecureRandom.hex(10)
		end


end
