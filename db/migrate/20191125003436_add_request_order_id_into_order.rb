class AddRequestOrderIdIntoOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :no_request_order, :integer
  end
end
