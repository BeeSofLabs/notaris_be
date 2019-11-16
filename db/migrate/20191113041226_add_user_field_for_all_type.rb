class AddUserFieldForAllType < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :address, :string
    add_column :users, :office_address, :string
    add_column :users, :komparisi, :text
    add_column :users, :occupation, :string
    add_column :users, :name_organization, :string
    add_column :users, :no_sk_notaris, :string
    add_column :users, :tgl_sk_notaris, :date
    add_column :users, :no_akta, :string
    add_column :users, :tgl_akta, :date
    add_column :users, :fax, :string
    add_column :users, :bank_account_notaris, :string
    add_column :users, :bank_name, :string

    add_column :users, :indonesia_city_id, :integer
  end
end
