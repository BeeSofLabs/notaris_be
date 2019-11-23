class CreateCollateralOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :collateral_orders do |t|
      t.references :order, foreign_key: true
      t.references :collateral, polymorphic: true

      t.timestamps
    end
  end
end
