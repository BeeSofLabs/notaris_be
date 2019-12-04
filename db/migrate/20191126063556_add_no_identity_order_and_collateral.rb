class AddNoIdentityOrderAndCollateral < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :no_order, :string, index: true
    add_column :movable_collaterals, :no_collateral, :string, index: true
    add_column :immovable_collaterals, :no_collateral, :string, index: true
  end
end
