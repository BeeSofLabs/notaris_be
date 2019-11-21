class RenameDeleteFields < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :delete, :is_deleted
  end
end
