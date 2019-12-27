class Api::V1::NotificationsController < ApplicationController
    def show
        notif = current_user.notifications.order(id: :desc)
        if notif
            json_response({ message: "notif found!", notif: notif }, :ok)
        else
            json_response({message: "Invalid notif", notif: {}}, :not_found)
        end
        
    end

    def create
        notif = Notification.build(notif_params[:action_name], current_user.id, notif_params[:title], notif_params[:description])
        if notif
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