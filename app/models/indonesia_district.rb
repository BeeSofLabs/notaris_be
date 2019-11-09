# == Schema Information
#
# Table name: indonesia_districts
#
#  id                :bigint(8)        not null, primary key
#  district_name     :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  indonesia_city_id :integer
#

class IndonesiaDistrict < ApplicationRecord
end
