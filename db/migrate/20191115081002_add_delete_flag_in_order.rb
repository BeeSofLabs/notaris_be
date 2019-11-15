class AddDeleteFlagInOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :delete, :boolean, default: false
  end
end
