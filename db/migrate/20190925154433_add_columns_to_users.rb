class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :organizational_status, :integer, default: 0
  	add_column :users, :phone, :string
  	add_column :users, :identity_number, :string
  	add_column :users, :gender, :integer
  end
end
