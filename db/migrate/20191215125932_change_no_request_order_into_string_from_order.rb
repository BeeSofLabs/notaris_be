class ChangeNoRequestOrderIntoStringFromOrder < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :no_request_order, :string
  end
end
