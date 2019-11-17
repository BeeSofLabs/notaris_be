# == Schema Information
#
# Table name: fidusia_collaterals
#
#  id                  :bigint(8)        not null, primary key
#  binding_value       :string
#  brand               :string
#  chassis_number      :string
#  classification      :string
#  collateral_value    :string
#  color               :string
#  imageable_type      :string
#  machine_number      :string
#  movable_asset       :boolean          default(FALSE)
#  name_representative :string
#  no_evidence         :string
#  owner               :string
#  proof_of_ownership  :string
#  publication_date    :datetime
#  seri                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  imageable_id        :bigint(8)
#  order_id            :integer
#
# Indexes
#
#  index_fidusia_collaterals_on_imageable_type_and_imageable_id  (imageable_type,imageable_id)
#

class FidusiaCollateral < ApplicationRecord
	belongs_to :order
end
