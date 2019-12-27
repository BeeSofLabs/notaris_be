class Notification < ApplicationRecord
    belongs_to :user

    enum :action => {"notif_registration":0, "notif_submission": 1, "notif_revision": 2, "notif_approval":3, "notif_paid":4, "notif_partial": 5,
        "notif_claim":6, "notif_expired":9,  "notif_cancel":10, "notif_deleted": 11,"notif_done": 20, "notif_completed": 21}
        

    def self.build(action, user_id, title, description)
        url_action = nil
        case actions[action]
        when actions[:notif_registration]
            url_action = ENV["NOTIF_REGISTRATION_URL_ACTION"]
            
        when actions[:notif_submission]
            url_action = ENV["NOTIF_SUBMISSION_URL_ACTION"]
        

        when actions[:notif_revision]
            url_action = ENV["NOTIF_REVISION_URL_ACTION"]
            
        when actions[:notif_approval]
            url_action = ENV["NOTIF_APPROVAL_URL_ACTION"]
        
        when actions[:notif_paid]
            url_action = ENV["NOTIF_PAID_URL_ACTION"]
            

        when actions[:notif_partial]
            url_action = ENV["NOTIF_PARTIAL_URL_ACTION"]
            

        when actions[:notif_claim]
            url_action = ENV["NOTIF_CLAIM_URL_ACTION"]
            
        end
        
        Notification.create({action: action, user_id: user_id, title: title, description: description, url_action: url_action})

    end
end