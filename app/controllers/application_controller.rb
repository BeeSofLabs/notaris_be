class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler

  def hello
  	json_response({message: "Hello There!"})
  end
end
