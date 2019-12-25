class AddTarifBungaIntoUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :tarif_bunga, :string, default: ""
  end
end
