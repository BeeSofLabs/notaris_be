class Api::V1::UsersController < ApplicationController
	skip_before_action :authorize_request, only: [:create, :roles, :notaris, :forgot, :reset]

  def create
    ActiveRecord::Base.transaction do
      user = User.create!(user_params)  
      
      user.set_user_role(user_params[:user_tipe])
      auth_token = AuthenticateUser.new(user.email, user.password).call

      identity_image = File.new(user.image_content(user.identity_image))
      selfie_image = File.new(user.image_content(user.selfie_image))
      
      # res = PrivyModule::registration(
      #   user.email, 
      #   user.phone, 
      #   user.identity_number, 
      #   user.name, 
      #   File.new(user.image_content(user.identity_image)), 
      #   File.new(user.image_content(user.selfie_image))
      # )
      # if privy_success_registration?(res)
      #   privy_token = res[:data][:userToken]
      #   user.insert_privy_token(privy_token)
      # end 

      response = { message: Message.account_created, auth_token: auth_token, privy: nil}  
      json_response(response, :created)
    end
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

  def forgot
    puts "=============================="
    puts "FORGOT PASSWORD YOU SHOULD HERE GOD DAMN IT!"
    puts "forgot params is #{params}"
    puts "email is: #{params[:email]}"
    puts "=============================="
    user = User.find_by!(email: params[:email])
    user.generate_password_token!
    UserMailer.forgot(user).deliver_now
    json_response({message: Message.success})
  end

  def reset
    user = User.find_by!(reset_password_token: reset_params[:reset_password_token])
    if user && user.valid_reset_password_token?
      if user.reset_password!(reset_params[:new_password])
        json_response({message: Message.success})
      else
        json_response({message: user.erros.full_messages}, :unprocessable_entity)
      end
    else
      json_response({message: "Invalid. try generating token again."}, :not_found)
    end
  end

  def roles
    json_response(User.roles)
  end

  def notaris
    json_response(User.notaris)
  end

  
  private

  def reset_params
    params.permit(
      :reset_password_token,
      :new_password
    )
  end

  def forgot_params
    params.permit(
      :email
    )
  end

  def user_params
  	params.permit(
  		:name, 
  		:email,
      :approved,
      :dob,
      :gender,
      :address,
      :identity_number,
      :identity_image,
      :selfie_image,
      :office_address,
      :komparisi,
      :occupation,
      :user_tipe,
      :organizational_status,
      :phone,
  		:password, 
  		:password_confirmation,
      :user_tipe,
      :province,
      :city,
      :district,
      :village,
      :lat,
      :lng,
      :name_organization,

      :no_sk_notaris,
      :tgl_sk_notaris,
      :no_akta,
      :tgl_akta,
      :fax,
      :bank_account_notaris,
      :bank_name,
      :indonesia_city_id,
      :indonesia_village_id,
    
      :name_companion,
      :idcard_number_companion,
      :gender_companion,
      :address_companion,
      :status_companion,
      :komparisi_companion,
      :lat_companion,
      :lng_companion,

      :name_ppat,
      :no_sk_notaris_ppat,
      :tgl_sk_ppat,
      :komparisi_ppat,
      :no_akta_ppat,
      :tgl_akta_ppat,
      :address_ppat,
      :fax_ppat,
      :no_rekening_ppat,
      :bank_name_ppat,
      :lat_ppat,
      :lng_ppat,

      :pob, 
      :mother_bpn,
      :address_in_idcard_bpn,
      :address_bpn
    
	)
  end

  def edit_params
  	params.permit(
  		:name,
      :dob,
      :identity_image,
      :identity_number,
      :organizational_status,
      :phone,
      :selfie_image
	)
  end

  def privy_approved?(res)
    res[:code] == 201 && res[:data][:status] ==  "verified"
  end

  def privy_success_registration?(res)
    res[:code] == 201 && res[:data][:userToken].present?
  end

end
