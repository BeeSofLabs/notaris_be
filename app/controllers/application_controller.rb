class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler
  protect_from_forgery unless: -> { request.format.json? }

	# called before every action on controller
	before_action :authorize_request
	skip_before_action :authorize_request, only: :hello
	attr_reader :current_user

	def hello
		json_response({message: "Hello There!"})
	end

	private
		def authorize_request
			@current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
		end
end
