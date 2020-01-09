class CreditorSerializer < ActiveModel::Serializer
    attributes 	:id,
              :name,
              :email,
              :approved,
              :organizational_status,
              :phone,
              :identity_number,
              :gender,
              :dob,
              :privy_token,
              :privy_id,
              :privy_status,
              :lng,
              :lat,
              :address,
              :office_address

end
