# == Schema Information
#
# Table name: users
#
#  id                    :bigint(8)        not null, primary key
#  approved              :boolean          default(FALSE)
#  dob                   :date
#  email                 :string
#  gender                :integer
#  identity_image        :string
#  identity_number       :string
#  name                  :string
#  organizational_status :integer          default("perorangan")
#  password_digest       :string
#  phone                 :string
#  privy_token           :string
#  selfie_image          :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
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

	mount_uploader :identity_image, ImageUploader 
	mount_uploader :selfie_image, 	ImageUploader

	has_many :orders
	has_one :notary_service

	def insert_privy_token(privy_token)
		update!(privy_token: privy_token)
	end

	def privy_approved
		update!(approved: true)
	end
end
