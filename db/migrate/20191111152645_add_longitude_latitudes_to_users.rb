class AddLongitudeLatitudesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :longitude, :string
    add_column :users, :latitudes, :string
  end
end
