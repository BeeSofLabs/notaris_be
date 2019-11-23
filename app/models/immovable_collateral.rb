# == Schema Information
#
# Table name: immovable_collaterals
#
#  id                  :bigint(8)        not null, primary key
#  binding_value       :integer
#  brand               :string
#  chasis_number       :string
#  classification      :string
#  collateral_value    :integer
#  color               :string
#  imageable_type      :string
#  machine_number      :string
#  name_representative :string
#  proof_of_ownership  :string
#  publication_date    :string
#  serial_number       :string
#  signed              :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  imageable_id        :bigint(8)
#  order_id            :integer
#
# Indexes
#
#  index_immovable_collaterals_on_imageable_type_and_imageable_id  (imageable_type,imageable_id)
#

# # == Schema Information
# #
# # Table name: collaterals
# #
# #  id              :bigint(8)        not null, primary key
# #  collateral_type :integer
# #  price           :decimal(, )      default(0.0)
# #  created_at      :datetime         not null
# #  updated_at      :datetime         not null
# #  order_id        :integer
# #
# # Indexes
# #
# #  index_collaterals_on_order_id  (order_id)
# #

class ImmovableCollateral < ApplicationRecord
	has_many :orders, as: :collateral
end
