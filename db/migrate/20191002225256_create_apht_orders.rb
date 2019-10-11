class CreateAphtOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :apht_orders do |t|
    	t.string :proof_of_ownership
    	t.string :collateral_value
    	t.string :owner
    	t.string :on_behalf_of
    	t.string :certificate_number
    	t.datetime :publication_date
    	t.string :province
    	t.string :city
    	t.string :district
    	t.string :village
    	t.string :street
    	t.string :surface_area
    	t.string :letter_of_measurement
    	t.datetime :tanggal_gs_su
    	t.string :land_area_identification_number
    	t.string :building_land_tax
    	t.string :nop
    	t.string :binding_value
    	t.integer :order_id

      t.timestamps
    end
    add_index :apht_orders, :order_id
  end
end
