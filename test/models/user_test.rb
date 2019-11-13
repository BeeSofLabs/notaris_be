# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  approved               :boolean          default(FALSE)
#  city                   :string
#  district               :string
#  dob                    :date
#  email                  :string
#  gender                 :integer
#  identity_image         :string
#  identity_number        :string
#  lat                    :float
#  lng                    :float
#  name                   :string
#  organizational_status  :integer          default("perorangan")
#  password_digest        :string
#  phone                  :string
#  privy_token            :string
#  province               :string
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  selfie_image           :string
#  user_tipe              :integer
#  village                :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
