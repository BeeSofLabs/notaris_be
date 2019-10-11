class AddNotaryIdToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :notary_id, :integer
    add_index :orders, :notary_id
  end
end
