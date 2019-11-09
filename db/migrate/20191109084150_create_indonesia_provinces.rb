class CreateIndonesiaProvinces < ActiveRecord::Migration[5.2]
  def change
    create_table :indonesia_provinces do |t|
      t.string :province_name

      t.timestamps
    end
  end
end
