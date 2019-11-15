class RemoveRedundantExpiredInOrder < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :expired_date
  end
end
