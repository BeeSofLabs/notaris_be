class AddCreditorIdIntoOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :creditor_id, :bigint
    add_index :orders, :creditor_id
  end
end
