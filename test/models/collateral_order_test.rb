# == Schema Information
#
# Table name: collateral_orders
#
#  id              :bigint(8)        not null, primary key
#  collateral_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  collateral_id   :bigint(8)
#  order_id        :bigint(8)
#
# Indexes
#
#  index_collateral_orders_on_collateral_type_and_collateral_id  (collateral_type,collateral_id)
#  index_collateral_orders_on_order_id                           (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#

require 'test_helper'

class CollateralOrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
