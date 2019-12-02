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

class User < ApplicationRecord
	rolify
	# encrypt password}
	has_secure_password

	# Validations
	validates_presence_of :name, :email, :phone, :password_digest
	validates_uniqueness_of :email
	validates_uniqueness_of :phone

	enum organizational_status: ["perorangan", "badan_usaha"]
	enum user_tipe: [ "debitur", "kreditur","collateral_owner", "notaris", "bpn"]

	mount_base64_uploader :identity_image, ImageUploader
	mount_base64_uploader :selfie_image, ImageUploader

	has_many :notary_orders, class_name: 'Order', foreign_key: 'notary_id', dependent: :nullify
	has_many :debtor_orders, class_name: 'Order', foreign_key: 'debtor_id', dependent: :nullify
	has_many :collateral_owner_orders, class_name: 'Order', foreign_key: 'collateral_owner_id', dependent: :nullify
	has_many :creditor_orders, class_name: 'Order', foreign_key: 'user_id', dependent: :nullify
  has_many :notary_services

  has_many :chats, dependent: :nullify

	has_many :movable_collaterals
	has_many :immovable_collaterals

	belongs_to :indonesia_city, optional: true
	belongs_to :indonesia_village, optional: true

	def insert_privy_token(privy_token, privy_status)
		update!(privy_token: privy_token, privy_status: privy_status)
	end

	def privy_approved(status, privy_id)
		update!(approved: true, privy_status: status, privy_id: privy_id)
	end

	def image_content(image)
		Rails.env.production? ? "#{image.path}" : "#{image.path}"
	end

	def self.search_by_pa_name(name=nil)
		User.collateral_owner.where("users.name like ?", name + '%')
	end

	def self.search_by_notaris_filter(name=nil)
		User.notaris.where("users.name like ? ", name + '%')
	end

	def self.roles
		%w(notaris
		debitur
		kreditur
		collateral_owner,
		bpn
		)
	end

	# def self.notaris
	# 	user = User.with_role("notaris")
	# end

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

  def self.filter(params, users)
    users = users.where("lower(users.name) like lower(?)", "%#{params[:name]}%") if params[:name].present?
    users = users.joins(:indonesia_city).where("lower(indonesia_cities.city_name) like lower(?)", "%#{params[:area]}%") if params[:area].present?
    users = users.joins(:notary_services).where(notary_services: { service_type: params[:doc_type] }) if params[:doc_type].present?
    users = users.joins(:notary_services).where(notary_services: { price: params[:range_lower]..params[:range_higher] }) if params[:range_lower].present? && params[:range_higher].present?
    users
  end

	private

		def generate_token
			SecureRandom.hex(10)
		end


end
