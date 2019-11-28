class ChangeSignedTypeFromImmovable < ActiveRecord::Migration[5.2]
  def change
    change_column :immovable_collaterals, :signed, :string
  end
end
