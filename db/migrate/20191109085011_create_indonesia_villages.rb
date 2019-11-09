class CreateIndonesiaVillages < ActiveRecord::Migration[5.2]
  def change
    create_table :indonesia_villages do |t|
      t.string :village_name
      t.integer :indonesia_district_id

      t.timestamps
    end
  end
end
