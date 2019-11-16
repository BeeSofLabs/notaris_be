class AddAphtFields < ActiveRecord::Migration[5.2]
  def change
    rename_column :apht_orders, :on_behalf_of, :name_representative
    rename_column :apht_orders, :surface_area, :land_area
    rename_column :apht_orders, :land_area_identification_number, :no_land_identity
    rename_column :apht_orders, :building_land_tax, :letter_of_pbbtax
  end
end
