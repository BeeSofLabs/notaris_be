# == Schema Information
#
# Table name: indonesia_villages
#
#  id                    :bigint(8)        not null, primary key
#  village_name          :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  indonesia_district_id :integer
#

class IndonesiaVillage < ApplicationRecord
	belongs_to :indonesia_district
end
