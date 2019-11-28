class CreateImmovableCollateralsOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :immovable_collaterals_orders do |t|
      t.belongs_to :immovable_collateral, index: true
      t.belongs_to :order, index: true
    end
  end
end
