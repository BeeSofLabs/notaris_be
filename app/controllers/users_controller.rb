class UsersController < ApplicationController
	skip_before_action :authorize_request, only: :create
  	def create
		user = User.create!(user_params)
		auth_token = AuthenticateUser.new(user.email, user.password).call
		response = { message: Message.account_created, auth_token: auth_token}
		json_response(response, :created)
	end

	def show
		json_response(current_user)
	end

	def edit
		current_user.update(edit_params)
		json_response(current_user)
	end

  
  private

  def user_params
  	params.permit(
  		:name, 
  		:email, 
  		:password, 
  		:password_confirmation
	)
  end

  def edit_params
  	params.permit(
  		:name, 
  		:password, 
  		:password_confirmation, 
  		:address
	)
  end
end