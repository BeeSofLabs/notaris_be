class AddOrderIdToFidusiaOrder < ActiveRecord::Migration[5.2]
  def change
  	add_column :fidusia_orders, :order_id, :integer
  end
end
