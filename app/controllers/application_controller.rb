class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler
  protect_from_forgery unless: -> { request.format.json? }

	
  def hello
  	json_response({message: "Hello There!"})
  end
end
