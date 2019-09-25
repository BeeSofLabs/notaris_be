class AddMoreColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :dob, :date
  	add_column :users, :identity_image, :string
  	add_column :users, :selfie_image, :string
  end
end
