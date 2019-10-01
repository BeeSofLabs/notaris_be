class UsersController < ApplicationController
	skip_before_action :authorize_request, only: :create
  	def create
		user = User.create!(user_params)
		auth_token = AuthenticateUser.new(user.email, user.password).call
    res = Privy.new(user).registration
    user.insert_privy_token(res["data"]["userToken"]) if res["code"] == 201 && res["data"]["userToken"].present?
    response = { message: Message.account_created, auth_token: auth_token, privy: res}
		json_response(response, :created)
	end

  def privy_status
    unless current_user.approved == true
      unless current_user.privy_token.present?
        response = {msg: "privy token not found", privy: {}}
      else
        res = Privy.new(current_user).registration_status
        current_user.privy_approved if privy_approved?(res)
        response = {msg: res["data"]["status"], privy: res}
      end
    else
      response = {msg: "approved", privy: {}}
    end
    json_response(response, :ok)
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
      :approved,
      :dob,
      :gender,
      :identity_image,
      :identity_number,
      :organizational_status,
      :phone,
      :selfie_image,
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

  def privy_approved?(res)
    res["code"] == 201 && res["data"]["status"] ==  "verified"
  end

end
