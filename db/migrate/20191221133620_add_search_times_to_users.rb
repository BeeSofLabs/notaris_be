class AddSearchTimesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :search_count, :integer, default: 0
    add_column :users, :last_locked_search_time, :datetime
  end
end
