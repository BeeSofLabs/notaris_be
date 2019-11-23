class CreateCollaterals < ActiveRecord::Migration[5.2]
  def change
    create_table :collaterals do |t|
      t.integer :collateral_type
      t.integer :order_id
      t.timestamps
    end
    add_index :collaterals, :order_id
  end
end