class AddPobToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :pob, :string
  end
end
