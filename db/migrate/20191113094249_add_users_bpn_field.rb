class AddUsersBpnField < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :mother_bpn, :string
    add_column :users, :address_in_idcard_bpn, :string
    add_column :users, :address_bpn, :string
  end
end
