class Notification < ApplicationRecord
    belongs_to :user

    enum :action => {"notif_registration":0, "notif_submission": 1, "notif_revision": 2, "notif_approval":3, "notif_paid":4, "notif_partial": 5,
        "notif_claim":6, "notif_expired":9,  "notif_cancel":10, "notif_deleted": 11,"notif_done": 20, "notif_completed": 21}
        

    # Notification.build(notif_params[:action_name], current_user.id, notif_params[:title], notif_params[:description])
    def self.build(action_type, user_id, description)
        url_action = nil
        case actions[action_type]
        when actions[:notif_registration]
            title = ENV["NOTIF_REGISTRATION_TITLE"]
            url_action = ENV["NOTIF_REGISTRATION_URL_ACTION"]
            
        when actions[:notif_submission]
            title = ENV["NOTIF_SUBMISSION_TITLE"]
            url_action = ENV["NOTIF_SUBMISSION_URL_ACTION"]
        

        when actions[:notif_revision]
            title = ENV["NOTIF_REVISION_TITLE"]
            url_action = ENV["NOTIF_REVISION_URL_ACTION"]
            
        when actions[:notif_approval]
            title = ENV["NOTIF_APPROVAL_TITLE"]
            url_action = ENV["NOTIF_APPROVAL_URL_ACTION"]
        
        when actions[:notif_paid]
            title = ENV["NOTIF_PAID_TITLE"]
            url_action = ENV["NOTIF_PAID_URL_ACTION"]
            

        when actions[:notif_partial]
            title = ENV["NOTIF_PARTIAL_TITLE"]
            url_action = ENV["NOTIF_PARTIAL_URL_ACTION"]
            

        when actions[:notif_claim]
            title = ENV["NOTIF_CLAIM_TITLE"]
            url_action = ENV["NOTIF_CLAIM_URL_ACTION"]
            
        when actions[:notif_done]
            title = ENV["NOTIF_DONE_TITLE"]


        when actions[:notif_completed]
            title = ENV["NOTIF_COMPLETED_TITLE"]

        when actions[:notif_delete]
            title = ENV["NOTIF_DELETED_TITLE"]

        when actions[:notif_cancel]
            title = ENV["NOTIF_CANCEL_TITLE"]


        when actions[:notif_expired]
            title = ENV["NOTIF_EXPIRED_TITLE"]


        end
        
        Notification.create({action_type: actions[action_type], user_id: user_id, title: title, description: description, url_action: url_action})

    end
end