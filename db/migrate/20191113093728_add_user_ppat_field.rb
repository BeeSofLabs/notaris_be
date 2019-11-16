class AddUserPpatField < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name_ppat, :string
    add_column :users, :no_sk_notaris_ppat, :string
    add_column :users, :tgl_sk_ppat, :date
    add_column :users, :komparisi_ppat, :text
    add_column :users, :no_akta_ppat, :string
    add_column :users, :tgl_akta_ppat, :date
    add_column :users, :address_ppat, :string
    add_column :users, :no_fak_ppat, :string
    add_column :users, :no_rekening_ppat, :string
    add_column :users, :bank_name_ppat, :string
    add_column :users, :lat_ppat, :float
    add_column :users, :lng_ppat, :float
  end
end
