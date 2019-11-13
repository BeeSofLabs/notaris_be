class ChangeTypeCoordinate < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :lng, :float
    change_column :users, :lat, :float
  end
end
