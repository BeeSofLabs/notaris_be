class CreateMovableCollateral < ActiveRecord::Migration[5.2]
  def change
    create_table :movable_collateral do |t|
      t.string :proof_of_ownership
      t.integer :collateral_value
      t.string  :signed
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
      t.string  :tgl_gs_su
      t.string  :no_land_identity
      t.string  :letter_of_pbbtax
      t.string  :nop
      t.integer  :binding_value
      t.integer  :order_id

      t.timestamps
    end
  end
end
