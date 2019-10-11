class Privy
	attr_reader :email, 
				:phone, 
				:selfie_image, 
				:identity_image,
				:identity,
				:name,
				:dob,
				:privy_token,
				:user


	def initialize(user)
		@user 				= user
		@email 				= user.email
		@phone 				= user.phone
		@selfie_image 		= user.selfie_image 
		@identity_image		= user.identity_image
		@identity 			= user.identity_number
		@dob 				= user.dob
		@name 				= user.name
		@privy_token		= user.privy_token
	end

	def headers
		headers = {
			"Authorization": "Basic " + Base64.strict_encode64("#{ENV["PRIVY_USERNAME"]}:#{ENV["PRIVY_PASSWORD"]}"),
			"Merchant-Key": ENV["MERCHANT_KEY"],
			"Content-Type": "multipart/form-data"
		}
	end

	def registration
		# post data to Privy here!
		body = {
			email: email,
			phone: phone,
			selfie: selfie_image,
			ktp: identity_image,
			identity: {
				nik: identity,
				nama: name,
				tanggalLahir: dob.present? ? dob.strftime("%Y-%m-%d") : dob
			}
		}
		data = HTTParty.post(
			"#{ENV["PRIVY_REGISTRATION_URL"]}",
			body: body.as_json,
			headers: headers
		)
	end

	def registration_status
		# check registration status goes here!
		body = {
			"token": privy_token
		}
		data = HTTParty.post(
			"#{ENV["PRIVY_REGISTRATION_STATUS_URL"]}",
			body: body,
			headers: headers
		)
	end

end
