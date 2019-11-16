class CreateNotarisOrder < ActiveRecord::Migration[5.2]
  def change
    create_table :notaris_orders do |t|
      t.string :proof_of_ownership
      t.string :owner
      t.string :collateral_value
      t.string :name_representative
      t.string :certificate_number
      t.string :no_evidence_fidusia
      t.string :publication_date
      t.string :province
    	t.string :city
    	t.string :district
      t.string :village
      t.string :street
    	t.string :land_area
    	t.string :letter_of_measurement
    	t.string :tgl_gs_su
    	t.string :no_land_identity
    	t.string :letter_of_pbbtax
      t.string :nop
      t.string :binding_value
      
      t.string :machine_number_fidusia
      t.string :chassis_number_fidusia
      t.string :brand_fidusia
      t.string :classification_fidusia
      t.string :seri_fidusia
      t.string :color_fidusia
      
      t.timestamps
    end
  end
end
