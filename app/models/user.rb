class User < ApplicationRecord
	rolify
	# encrypt password}
	has_secure_password

	# Validations
	validates_presence_of :name, :email, :password_digest
	validates_uniqueness_of :email
end
