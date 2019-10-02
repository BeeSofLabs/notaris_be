# == Schema Information
#
# Table name: orders
#
#  id          :bigint(8)        not null, primary key
#  grand_total :integer
#  order_type  :integer
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  notary_id   :integer
#
# Indexes
#
#  index_orders_on_notary_id  (notary_id)
#

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
