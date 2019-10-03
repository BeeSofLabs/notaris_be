# == Schema Information
#
# Table name: notary_services
#
#  id           :bigint(8)        not null, primary key
#  price        :decimal(, )
#  service_type :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#
# Indexes
#
#  index_notary_services_on_user_id  (user_id)
#

class NotaryService < ApplicationRecord
	enum :service_type => ["fidusia", "skmht", "apht", "skmht and apht"] 
end
