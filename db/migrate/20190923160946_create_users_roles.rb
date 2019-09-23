class CreateUsersRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :users_roles do |t|
      t.references :users, foreign_key: true
      t.references :roles, foreign_key: true

      t.timestamps
    end
  end
end
