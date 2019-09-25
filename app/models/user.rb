# == Schema Information
#
# Table name: users
#
#  id                    :bigint(8)        not null, primary key
#  approved              :boolean          default(FALSE)
#  email                 :string
#  gender                :integer
#  identity_number       :string
#  name                  :string
#  organizational_status :integer          default("perorangan")
#  password_digest       :string
#  phone                 :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class User < ApplicationRecord
	rolify
	# encrypt password}
	has_secure_password

	# Validations
	validates_presence_of :name, :email, :password_digest
	validates_uniqueness_of :email

	enum organizational_status: ["perorangan", "perusahaan"]
	enum gender: ["laki-laki", "perempuan"]
end
