class LatitudesIntoLatitude < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :latitudes, :lat
    rename_column :users, :longitude, :lng
  end
end
