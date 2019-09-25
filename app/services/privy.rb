class Privy
	attr_reader :email, 
				:phone, 
				:selfie, 
				:ktp,
				:identity,
				:name,
				:dob


	def initialize(opts)
		@email 		= opts[:email]
		@phone 		= opts[:phone]
		@selfie 	= opts[:selfie] 
		@ktp 		= opts[:ktp]
		@identity 	= opts[:identity]
		@name 		= opts[:name]
		@dob 		= opts[:dob]
	end

	def registration
		# post data to Privy here!
	end

	def registration_status
		# check registration status goes here!
	end
end
