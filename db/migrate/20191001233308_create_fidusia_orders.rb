class CreateFidusiaOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :fidusia_orders do |t|
      t.string :proof_of_ownership
      t.string :owner
      t.string :on_behalf_of
      t.string :number_of_evidence
      t.datetime :publication_date
      t.string :machine_number
      t.string :chassis_number
      t.string :brand
      t.string :tipe
      t.string :seri
      t.string :chassis_number
      t.string :collateral_value
      t.string :binding_value
      t.references :imageable, polymorphic: true
      t.timestamps
    end
  end
end
