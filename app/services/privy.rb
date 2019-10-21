require 'rest-client'

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
			:authorization => "Basic " + Base64.strict_encode64("#{ENV["PRIVY_USERNAME"]}:#{ENV["PRIVY_PASSWORD"]}"),
			:merchant_key => "#{ENV["MERCHANT_KEY"]}",
			:content_type => 'application/x-www-form-urlencoded'
		}
	end

	def registration
		# post data to Privy here!
		conn =
				Faraday.new do |f|
				  f.request :multipart
				  f.request :url_encoded
				  f.adapter :net_http
				end
		selfie 	= Faraday::UploadIO.new("/home/jhon/Desktop/img/avatar_young.jpg", 'image/jpeg')
		ktp 	= Faraday::UploadIO.new("/home/jhon/Desktop/img/avatar_young.jpg", 'image/jpeg')
		tanggal_lahir = dob.present? ? dob.strftime("%Y-%m-%d") : dob

		body = {
		  	email: email,
			phone: phone,
			selfie: selfie,
			ktp: ktp,
			identity: "{
							'nik': '#{identity}',
							'nama': '#{name}',
							'tanggalLahir': '#{tanggal_lahir}'
						}"
		}.as_json

		data = conn.post("#{ENV["PRIVY_REGISTRATION_URL"]}", body, headers)
		# byebug

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

	def upload
		body = {
			"documentTitle": "documentTitle",
			"docType": "Parallel",
			"document": "file",
			"recipients": [
							{
							"privyId": "TES002",
							"type": "Signer",
							"enterpriseToken": "41bc84b42c8543daf448d893c255be1dbdcc722e"
							},
							{
							"privyId": "TES001",
							"type": "Reviewer",
							"enterpriseToken": ""
							}
						],
			"owner": {
						"privyId": "TE4455",
						"enterpriseToken": "41bc84b42c8543daf448d893c255be1dbdcc722e"
						} 
		}
		# byebug
		data = HTTParty.post(
			"#{ENV["PRIVY_UPLOAD_URL"]}",
			body: body,
			headers: headers
			)
	end

	def check
		document_id = "3c20edappl0015b7d6999760568168b7389bb108fa3ac365083ba496be92d"
		data = Faraday.new(
			"#{ENV['PRIVY_CHECK_URL']}#{document_id}",
			headers: headers
			).get
		# byebug
	end

end
