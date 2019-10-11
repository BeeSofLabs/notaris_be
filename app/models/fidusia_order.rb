# == Schema Information
#
# Table name: fidusia_orders
#
#  id                 :bigint(8)        not null, primary key
#  binding_value      :string
#  brand              :string
#  chassis_number     :string
#  collateral_value   :string
#  imageable_type     :string
#  machine_number     :string
#  number_of_evidence :string
#  on_behalf_of       :string
#  owner              :string
#  proof_of_ownership :string
#  publication_date   :datetime
#  seri               :string
#  tipe               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  imageable_id       :bigint(8)
#  order_id           :integer
#
# Indexes
#
#  index_fidusia_orders_on_imageable_type_and_imageable_id  (imageable_type,imageable_id)
#

class FidusiaOrder < ApplicationRecord
	belongs_to :order
end
