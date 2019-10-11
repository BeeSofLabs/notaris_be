class AddExpiredDateToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :expired_date, :datetime
  end
end
