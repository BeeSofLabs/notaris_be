class RenameTotalPriceIntoOrder < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :grand_total, :total_price
  end
end
