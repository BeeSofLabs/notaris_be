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
				:privy_token
	has_many 	:notary_services, if: :notaris?

	def notaris?
		object.has_role?(:notaris)
	end
end
