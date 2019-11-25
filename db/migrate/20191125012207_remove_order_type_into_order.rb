class RemoveOrderTypeIntoOrder < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :order_type
  end
end
