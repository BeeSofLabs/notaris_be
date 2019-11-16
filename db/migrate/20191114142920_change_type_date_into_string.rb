class ChangeTypeDateIntoString < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :dob, :string
    change_column :users, :tgl_sk_notaris, :string
    change_column :users, :tgl_akta, :string
    change_column :users, :tgl_sk_ppat, :string
    change_column :users, :tgl_akta_ppat, :string
  end
end
