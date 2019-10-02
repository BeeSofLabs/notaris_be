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
#

class Order < ApplicationRecord
	has_one :fidusia_order
	has_one :skmht_order
	has_many :collaterals

	enum :order_type => ["fidusia", "skmht", "apht", "skmht and apht"]
end
