class AuthenticateUser
	def initialize(email, password)
		@email = email
		@password = password
	end

	# service entry point
	def call
		if user
			{ auth_token: JsonWebToken.encode(user_id: user.id),
			user: UserSerializer.new(user).as_json }
		end 
	end

	private
		attr_reader :email, :password

		def user
			user = User.find_by(email: email)
			return user if user && user.authenticate(password)
		# raise Authenticate error if credentials are invalid
		raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
		end
end