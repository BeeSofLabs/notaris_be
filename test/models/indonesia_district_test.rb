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

require 'test_helper'

class IndonesiaDistrictTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
