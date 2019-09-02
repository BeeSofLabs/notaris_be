class JsonWebToken
	# secret to encode and decode token
	HMAC_SECRET = ENV["SECRET_KEY_BASE"]

	def self.encode(payload, exp = 42.hours.from_now)
		# set expiry to 48 hours from creation
		payload[:exp] = exp.to_i
		# sign token with application secret
		JWT.encode(payload, HMAC_SECRET)
	end

	def self.decode(token)
		# get payload; first index in decode array
		body = JWT.decode(token, HMAC_SECRET)[0]
		HashWithIndifferentAccess.new(body)
	rescue JWT::DecodeError => e
		# raise custome error to be handle by custome handler
		raise ExceptionHandler::InvalidToken, e.message
	end
end