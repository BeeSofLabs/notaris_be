# == Schema Information
#
# Table name: movable_collaterals
#
#  id                  :bigint(8)        not null, primary key
#  binding_value       :float            default(0.0)
#  brand               :string
#  chassis_number      :string
#  classification      :string
#  collateral_value    :float            default(0.0)
#  color               :string
#  machine_number      :string
#  name_representative :string
#  no_evidence         :string
#  owner               :string
#  proof_of_ownership  :string
#  publication_date    :string
#  serial_number       :string
#  signed              :string           default("false")
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class MovableCollateral < ApplicationRecord
  has_many :collateral_orders, as: :collateral, dependent: :nullify
end
