# == Schema Information
#
# Table name: indonesia_cities
#
#  id                    :bigint(8)        not null, primary key
#  city_name             :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  indonesia_province_id :integer
#

require 'test_helper'

class IndonesiaCityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
