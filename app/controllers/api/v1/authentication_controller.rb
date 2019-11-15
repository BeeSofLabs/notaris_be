class Api::V1::AuthenticationController < ApplicationController
	skip_before_action :authorize_request, only: :authenticate
	def authenticate
		user_auth = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
		json_response(user_auth)
	end

	private
		def auth_params
			params.permit(:email, :password)
		end
end
