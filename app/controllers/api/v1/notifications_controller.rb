class Api::V1::NotificationsController < ApplicationController
    def show
        notif = current_user.notifications.order(id: :desc, created_at: :desc)
        if notif
            current_user.notifications.update_all(is_read: true)
            json_response({ message: "notif found!", notif: notif }, :ok)
        else
            json_response({message: "Invalid notif", notif: {}}, :not_found)
        end
        
    end

    def notif_params
		params.permit(
            :action_name,
            :title,
            :description 
		)
	end
end