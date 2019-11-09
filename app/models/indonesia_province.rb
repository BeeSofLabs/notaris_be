# == Schema Information
#
# Table name: indonesia_provinces
#
#  id            :bigint(8)        not null, primary key
#  province_name :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class IndonesiaProvince < ApplicationRecord
	has_many :indonesia_cities
end
