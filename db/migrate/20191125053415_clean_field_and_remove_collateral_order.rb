class CleanFieldAndRemoveCollateralOrder < ActiveRecord::Migration[5.2]
  def change
    remove_column :movable_collaterals, :imageable_type
    remove_column :movable_collaterals, :imageable_id

    drop_table :collateral_orders
  end
end
