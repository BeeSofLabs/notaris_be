# == Schema Information
#
# Table name: immovable_collaterals
#
#  id                    :bigint(8)        not null, primary key
#  binding_value         :float            default(0.0)
#  certificate_number    :string
#  city                  :string
#  collateral_value      :float            default(0.0)
#  district              :string
#  gs_su_date            :string
#  land_area             :string
#  letter_of_measurement :string
#  letter_of_pbbtax      :string
#  name_representative   :string
#  no_collateral         :string
#  no_land_identity      :string
#  nop                   :string
#  owner                 :string
#  proof_of_ownership    :string
#  province              :string
#  publication_date      :string
#  signed                :string           default("false")
#  street                :string
#  village               :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_id               :bigint(8)
#
# Indexes
#
#  index_immovable_collaterals_on_user_id  (user_id)
#

class ImmovableCollateral < ApplicationRecord
  # has_many :collateral_orders, as: :collateral, dependent: :nullify
  has_and_belongs_to_many :orders
  belongs_to :user

  def self.save(params)
    ActiveRecord::Base.transaction do
        collateral =  self.create(params)
    end 
  end
end
