class RenameColumnsOnUsersRoles < ActiveRecord::Migration[5.2]
  def change
  	rename_column :users_roles, :roles_id, :role_id
  	rename_column :users_roles, :users_id, :user_id
  end
end
