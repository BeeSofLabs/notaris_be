class ChangeTglFromDateToString < ActiveRecord::Migration[5.2]
  def change
    change_column :skmht_orders, :tanggal_gs_su, :string
    rename_column :skmht_orders, :tanggal_gs_su, :tgl_gs_su
    change_column :apht_orders, :tanggal_gs_su, :string
    rename_column :apht_orders, :tanggal_gs_su, :tgl_gs_su
  end
end
