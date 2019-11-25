class DropTableSkmhtAphtFidusia < ActiveRecord::Migration[5.2]
  def change
    drop_table :skmht_collaterals
    drop_table :apht_collaterals
    drop_table :fidusia_collaterals
  end
end
