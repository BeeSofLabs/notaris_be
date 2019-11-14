# == Schema Information
#
# Table name: skmht_orders
#
#  id                    :bigint(8)        not null, primary key
#  binding_value         :string
#  certificate_number    :string
#  city                  :string
#  collateral_value      :string
#  district              :string
#  land_area             :string
#  letter_of_measurement :string
#  letter_of_pbbtax      :string
#  name_representative   :string
#  no_land_identity      :string
#  nop                   :string
#  owner                 :string
#  proof_of_ownership    :string
#  province              :string
#  publication_date      :datetime
#  street                :string
#  tanggal_gs_su         :datetime
#  village               :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  order_id              :integer
#
# Indexes
#
#  index_skmht_orders_on_order_id  (order_id)
#

require 'test_helper'

class SkmhtOrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
