class CreateMovableCollateralsOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :movable_collaterals_orders do |t|
      t.belongs_to :movable_collateral, index: true
      t.belongs_to :order, index: true
    end
  end
end
