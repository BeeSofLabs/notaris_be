# == Schema Information
#
# Table name: apht_orders
#
#  id                              :bigint(8)        not null, primary key
#  binding_value                   :string
#  building_land_tax               :string
#  certificate_number              :string
#  city                            :string
#  collateral_value                :string
#  district                        :string
#  land_area_identification_number :string
#  letter_of_measurement           :string
#  nop                             :string
#  on_behalf_of                    :string
#  owner                           :string
#  proof_of_ownership              :string
#  province                        :string
#  publication_date                :datetime
#  street                          :string
#  surface_area                    :string
#  tanggal_gs_su                   :datetime
#  village                         :string
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  order_id                        :integer
#
# Indexes
#
#  index_apht_orders_on_order_id  (order_id)
#

require 'test_helper'

class AphtOrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
