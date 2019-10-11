# == Schema Information
#
# Table name: collaterals
#
#  id              :bigint(8)        not null, primary key
#  collateral_type :integer
#  price           :decimal(, )      default(0.0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  order_id        :integer
#
# Indexes
#
#  index_collaterals_on_order_id  (order_id)
#

require 'test_helper'

class CollateralTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
