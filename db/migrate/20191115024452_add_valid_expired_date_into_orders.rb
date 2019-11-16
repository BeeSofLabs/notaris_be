class AddValidExpiredDateIntoOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :valid_expired_datetime, :datetime
  end
end
