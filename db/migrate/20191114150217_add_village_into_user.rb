class AddVillageIntoUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :indonesia_village_id, :integer, after: "indonesia_city_id"
  end
end
