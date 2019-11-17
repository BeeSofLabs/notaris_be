class CreateMenuHomePreview < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_home_previews do |t|
      t.string :menu_image
      t.string :label
      t.string :link_url
      t.integer :position, default: 0
    end
  end
end
