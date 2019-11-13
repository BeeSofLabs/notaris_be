# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  approved               :boolean          default(FALSE)
#  city                   :string
#  district               :string
#  dob                    :date
#  email                  :string
#  gender                 :integer
#  identity_image         :string
#  identity_number        :string
#  lat                    :float
#  lng                    :float
#  name                   :string
#  organizational_status  :integer          default("perorangan")
#  password_digest        :string
#  phone                  :string
#  privy_token            :string
#  province               :string
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  selfie_image           :string
#  user_tipe              :integer
#  village                :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
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
				:privy_token,
				:lat,
				:lng
				
	has_many 	:notary_services, if: :notaris?

	def notaris?
		object.has_role?(:notaris)
	end
end
