class AddNewFieldRelatedPrivyIntoUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :privy_id, :string
    add_column :users, :privy_status, :string
    
    add_column :users, :skmht_price, :decimal, default: 0.0
    add_column :users, :apht_price, :decimal, default: 0.0
    add_column :users, :fidusia_price, :decimal, default: 0.0
  end
end
