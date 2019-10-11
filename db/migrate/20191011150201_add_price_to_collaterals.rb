class AddPriceToCollaterals < ActiveRecord::Migration[5.2]
  def change
    add_column :collaterals, :price, :decimal, default: 0.0
  end
end
