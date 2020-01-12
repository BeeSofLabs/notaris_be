class AddLinkMapLocationIntoUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :link_map_location, :string
    add_column :users, :link_map_location_companion, :string
    add_column :users, :link_map_location_ppat, :string
  end
end
