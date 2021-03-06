class Api::V1::UsersController < ApplicationController
	skip_before_action :authorize_request, only: [:create, :roles, :notaris, :forgot, :reset, :notaris_detail]
  # serialization_scope :current_user

  def verify
    result = User.find_by_email(params[:email])
    if result
      return json_response({message: "Not Valid email"}, :not_found)
    end

    result = User.find_by_phone(params[:phone])
    if result
      return json_response({message: "Not Valid phone"}, :not_found)
    end

    json_response({message: "Valid"}, :ok)
  end

  def search_collateral_owner
    ActiveRecord::Base.transaction do
        result = User.collateral_owner.where("name LIKE ?", "%#{params[:owner]}%")
        response = { message: "Ok", collateral_owners: result}

        return json_response({message: "ok",
          collateral_owners:
            result.map do |user|
              {
                id: user.id,
                name: user.name,
                email: user.email
              }
            end
          }, :ok)
    end

    json_response({message: "invalid action", collateral_owners: []}, :invalid)

  end

  def search_debitor
    ActiveRecord::Base.transaction do
        result = User.debtor.where("name LIKE ?", "%#{params[:owner]}%")

        return json_response({message: "ok",
        debtors:
            result.map do |user|
              {
                id: user.id,
                name: user.name,
                email: user.email
              }
            end
          }, :ok)
    end

    json_response({message: "invalid action", debitors: []}, :invalid)

  end

  def search_creditor
    ActiveRecord::Base.transaction do
        result = User.creditor.where("name LIKE ?", "%#{params[:owner]}%")

        return json_response({message: "ok",
        creditors:
            result.map do |user|
              {
                id: user.id,
                name: user.name,
                email: user.email
              }
            end
          }, :ok)
    end

    json_response({message: "invalid action", creditors: []}, :invalid)

  end

  def create
    ActiveRecord::Base.transaction do
      user = User.create!(user_params)

      user.set_user_role(user_params[:user_tipe])
      auth_token = AuthenticateUser.new(user.email, user.password).call

      res = nil
      # if(user_params[:user_tipe] != 'bpn')

        res = PrivyModule::registration(
          user.email,
          user.phone,
          user.identity_number,
          user.name,
          File.new(user.image_content(user.identity_image)),
          File.new(user.image_content(user.selfie_image))
        )


        if privy_success_registration?(res)
          privy_token = res[:data][:userToken]
          privy_status = res[:data][:status]
          user.insert_privy_token(privy_token, privy_status)

          Notification.build("notif_registration", user.id, "Akun anda telah dibuat")
        else
          # raise Exception
          raise(ExceptionHandler::DuplicateRecord, { message: res })
          # json_response({ message: res }, :unprocessable_entity)
        end
      # end

      response = { message: Message.account_created, auth_token: auth_token, privy: res}
      json_response(response, :created)
    end
  end

  def privy_status
    unless current_user.approved == true
      unless current_user.privy_token.present?
        response = {msg: "privy token not found", privy: {}}
      else
        # res = Privy.new(current_user).registration_status
        res = PrivyModule.status_of_registration(current_user.privy_token)
        current_user.privy_approved(res[:data][:status], res[:data][:privyId]) if privy_approved?(res)
        response = {msg: current_user.privy_status, privy: res}
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
		current_user.update_profile(edit_params)
		json_response(current_user)
	end

  def forgot
    puts "=============================="
    puts "FORGOT PASSWORD YOU SHOULD HERE GOD DAMN IT!"
    puts "forgot params is #{forgot_params}"
    puts "email is: #{forgot_params[:email]}"
    puts "=============================="
    user = User.find_by!(email: forgot_params[:email])
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
    # users = User.notaris
    # check_last_locked_times = user_services.check_last_locked(current_user)
    user = User.find_by(id: params[:user_id])
    UserServices.check_locked(user) if user.present?
    notaries = User.joins(:roles).where("roles.name = ?", "notaris")
    notaries = User.filter(params, notaries)
    json_response(notaries)
    # json_response_with_serializer(notaries, { adapter: :json, root: "user" })
  end

  def notaris_detail
    notaris = User.joins(:roles).where("roles.name = ? and users.id = ?", "notaris", params[:id])
    json_response(notaris)
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
 #  	params.permit(
 #  		:name,
 #      :dob,
 #      :identity_image,
 #      :identity_number,
 #      :organizational_status,
 #      :phone,
 #      :selfie_image
	# )
    params.permit(
      users: [
        :name,
        :dob,
        :identity_image,
        :identity_number,
        :organizational_status,
        :phone,
        :selfie_image,
        :address,
        :address_bpn,
        :address_companion,
        :address_in_idcard_bpn,
        :address_ppat,
        :indonesia_city_id,
        :indonesia_village_id,
        :active
      ],
      services: [
        :id,
        :price
      ]
    )
  end

  def privy_approved?(res)
    res[:code] == 201 && res[:data][:status] ==  "verified"
  end

  def privy_success_registration?(res)
    res[:code] == 201 && res[:data][:userToken].present?
  end

end
