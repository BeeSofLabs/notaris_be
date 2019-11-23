class DropCollateral < ActiveRecord::Migration[5.2]
  def change
    drop_table :collaterals do |t|
      t.integer :collateral_type, null: false
      t.float :price
      t.integer :order_id
      t.timestamps null: false
    end
  end
end
