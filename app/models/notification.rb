class Notification < ApplicationRecord
    belongs_to :user

    enum :action => {"notif_registration":0, "notif_submission": 1, "notif_revision": 2, "notif_approval":3, "notif_paid":4, "notif_partial": 5,
        "notif_claim":6, "notif_expired":9,  "notif_cancel":10, "notif_deleted": 11,"notif_done": 20, "notif_completed": 21}
        

    def self.build(action, title, description)
        url_action = nil
        case action
        when action[:notif_registration]
            url_action = ""
            
        when action[:notif_submission]
            url_action = ""
        

        when action[:notif_revision]
            url_action = ""
            
        when action[:notif_approval]
            url_action = ""
        
        when action[:notif_paid]
            url_action = ""
            

        when action[:notif_partial]
            url_action = ""
            

        when action[:notif_claim]
            url_action = ""
            
        end
        
        Notification.create({action: action, title: title, description: description, url_action: url_action})

    end
end