class Privy
	attr_reader :email, 
				:phone, 
				:selfie_image, 
				:identity_image,
				:identity,
				:name,
				:dob,
				:token


	def initialize(opts)
		@email 		= opts[:email]
		@phone 		= opts[:phone]
		@selfie_image 	= opts[:selfie_image] 
		@identity_image	= opts[:identity_image]
		@identity 	= opts[:identity]
		@name 		= opts[:name]
		@dob 		= opts[:dob],
		@token		= opts[:token]
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
				"nik": identity,
				"nama": name,
				"tanggalLahir": dob
			}
		}

		data = HTTParty.post(
			"#{ENV["PRIVY_REGISTRATION_URL"]}",
			body: body,
			headers: headers
		)
	end

	def registration_status
		# check registration status goes here!
		body = {
			"token": token
		}
		data = HTTParty.post(
			"#{ENV["PRIVY_REGISTRATION_STATUS_URL"]}",
			body: body,
			headers: headers
		)
	end

end
