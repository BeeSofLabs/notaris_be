class AddReferenceUserToCollateral < ActiveRecord::Migration[5.2]
  def change
    add_reference :immovable_collaterals, :user, index: true
    add_reference :movable_collaterals, :user, index: true
  end
end
