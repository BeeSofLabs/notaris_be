class RemoveColumnFrom < ActiveRecord::Migration[5.2]
  def change
  	remove_column :orders, :orderable_id
  	remove_column :orders, :orderable_type
  end
end
