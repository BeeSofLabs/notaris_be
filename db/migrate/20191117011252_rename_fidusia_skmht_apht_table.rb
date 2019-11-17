class RenameFidusiaSkmhtAphtTable < ActiveRecord::Migration[5.2]
  def change
      rename_table :skmht_orders, :skmht_collaterals
      rename_table :apht_orders, :apht_collaterals
      rename_table :fidusia_orders, :fidusia_collaterals
  end
end
