class CreateImmovableCollateral < ActiveRecord::Migration[5.2]
  def change
    create_table :immovable_collaterals do |t|
      t.string :proof_of_ownership
      t.string :signed
      t.string :name_representative
      t.string :publication_date
      t.string :machine_number
      t.string :chasis_number
      t.string :brand
      t.string :classification
      t.string :serial_number
      t.integer :collateral_value
      t.integer :binding_value
      t.references :imageable, polymorphic: true
      t.string :color
      t.integer :order_id

      t.timestamps
    end
  end
end
