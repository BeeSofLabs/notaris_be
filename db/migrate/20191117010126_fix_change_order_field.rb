class FixChangeOrderField < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :no_perjanjian, :string
    add_column :orders, :plafond, :integer
    add_column :orders, :tgl_akad, :string
    add_column :orders, :tgl_jatuh_tempo, :string
    add_column :orders, :jangka_waktu, :string
    add_column :orders, :agunan_pokok, :integer
    add_column :orders, :angsuran_bunga, :integer  
  end
end
