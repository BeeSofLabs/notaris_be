class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :status
      t.integer :grand_total
      t.bigint  :orderable_id
      t.string  :orderable_type

      t.timestamps
    end
    add_index :orders, [:orderable_type, :orderable_id]

  end
end
