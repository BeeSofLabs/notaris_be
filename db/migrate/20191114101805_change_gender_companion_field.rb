class ChangeGenderCompanionField < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :gender_companion, :string
  end
end
