class RemoveOrderInMovableImmovable < ActiveRecord::Migration[5.2]
  def change
    remove_column :movable_collaterals, :order_id, :integer
    remove_column :immovable_collaterals, :order_id, :integer
  end
end
