# == Schema Information
#
# Table name: users
#
#  id                    :bigint(8)        not null, primary key
#  approved              :boolean          default(FALSE)
#  email                 :string
#  gender                :integer
#  identity_number       :string
#  name                  :string
#  organizational_status :integer          default("perorangan")
#  password_digest       :string
#  phone                 :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
