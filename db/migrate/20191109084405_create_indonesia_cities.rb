class CreateIndonesiaCities < ActiveRecord::Migration[5.2]
  def change
    create_table :indonesia_cities do |t|
      t.string :city_name
      t.integer :indonesia_province_id

      t.timestamps
    end
  end
end
