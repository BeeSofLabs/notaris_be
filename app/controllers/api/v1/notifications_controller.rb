class Api::V1::NotificationController < ApplicationController

    def show
        notif = Notification.all.order(:created_at)

        response = {msg: "Notification listed", data: notif}
        json_response(response, :ok)
    end
end

