# == Schema Information
#
# Table name: collaterals
#
#  id              :bigint(8)        not null, primary key
#  collateral_type :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  order_id        :integer
#
# Indexes
#
#  index_collaterals_on_order_id  (order_id)
#

class Collateral < ApplicationRecord
	belongs_to :order
end
