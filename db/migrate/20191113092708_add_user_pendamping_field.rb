class AddUserPendampingField < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name_companion, :string
    add_column :users, :idcard_number_companion, :string
    add_column :users, :gender_companion, :string, limit: 1
    add_column :users, :address_companion, :string
    add_column :users, :status_companion, :string
    add_column :users, :komparisi_companion, :text
    add_column :users, :lat_companion, :float
    add_column :users, :lng_companion, :float
  end
end
