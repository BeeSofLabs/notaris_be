class CreateNotaryServices < ActiveRecord::Migration[5.2]
  def change
    create_table :notary_services do |t|
      t.integer :service_type
      t.decimal :price

      t.timestamps
    end
  end
end
