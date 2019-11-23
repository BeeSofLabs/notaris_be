class CreateMovableCollateral < ActiveRecord::Migration[5.2]
  def change
    create_table :movable_collaterals do |t|
      t.string :proof_of_ownership
      t.boolean :signed, default: false
      t.string :owner
      t.string :no_evidence
      t.string :name_representative
      t.string :publication_date
      t.string :machine_number
      t.string :chassis_number
      t.string :brand
      t.string :classification
      t.string :serial_number
      t.float :collateral_value, default: 0.0
      t.float :binding_value, default: 0.0
      t.references :imageable, polymorphic: true
      t.string :color
      t.integer :order_id

      t.timestamps
    end
  end
end
