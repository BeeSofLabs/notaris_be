class AddDebtorAndCollateralToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :collateral_owner_id, :bigint
    add_index :orders, :collateral_owner_id

    add_column :orders, :debtor_id, :bigint
    add_index :orders, :debtor_id
  end
end
