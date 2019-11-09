class AddressColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :province, :string
  	add_column :users, :city, :string
  	add_column :users, :district, :string
  	add_column :users, :village, :string
  end
end
