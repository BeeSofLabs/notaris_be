class AddBendaBergerakField < ActiveRecord::Migration[5.2]
  def change
    add_column :skmht_collaterals, :movable_asset, :boolean, default: false
    add_column :apht_collaterals, :movable_asset, :boolean, default: false
    add_column :fidusia_collaterals, :movable_asset, :boolean, default: false
  end
end
