class ChangeSignedTypeFromMovable < ActiveRecord::Migration[5.2]
  def change
    change_column :movable_collaterals, :signed, :string
  end
end
