class CreateImmovableCollateral < ActiveRecord::Migration[5.2]
  def change
    create_table :immovable_collaterals do |t|
      t.string :proof_of_ownership
      t.float :collateral_value, default: 0.0
      t.boolean  :signed, default: false
      t.string  :owner
      t.string  :name_representative
      t.string  :certificate_number
      t.string  :publication_date
      t.string  :province
      t.string  :city
      t.string  :district
      t.string  :village
      t.string  :street
      t.string  :land_area
      t.string  :letter_of_measurement
      t.string  :gs_su_date
      t.string  :no_land_identity
      t.string  :letter_of_pbbtax
      t.string  :nop
      t.float  :binding_value, default: 0.0
      t.integer  :order_id

      t.timestamps
    end
  end
end
