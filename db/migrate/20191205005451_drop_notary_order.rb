class DropNotaryOrder < ActiveRecord::Migration[5.2]
  def change
    drop_table :notaris_orders
  end
end
