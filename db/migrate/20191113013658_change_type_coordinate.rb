class ChangeTypeCoordinate < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :lng, :float, using: 'lng::float'
    change_column :users, :lat, :float, using: 'lat::float'
  end
end
