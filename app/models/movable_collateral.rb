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
#  no_collateral       :string
#  no_evidence         :string
#  owner               :string
#  proof_of_ownership  :string
#  publication_date    :string
#  serial_number       :string
#  signed              :string           default("false")
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :bigint(8)
#
# Indexes
#
#  index_movable_collaterals_on_user_id  (user_id)
#

class MovableCollateral < ApplicationRecord
  has_many :collateral_orders, as: :collateral, dependent: :nullify
  belongs_to :user

  def self.save(params)
    ActiveRecord::Base.transaction do
        collateral =  self.create(params)
    end 
  end
end
