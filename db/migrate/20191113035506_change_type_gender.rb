class ChangeTypeGender < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :gender, :string, limit: 1
  end
end
