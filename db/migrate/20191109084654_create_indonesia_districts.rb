class CreateIndonesiaDistricts < ActiveRecord::Migration[5.2]
  def change
    create_table :indonesia_districts do |t|
      t.string :district_name
      t.integer :indonesia_city_id

      t.timestamps
    end
  end
end
