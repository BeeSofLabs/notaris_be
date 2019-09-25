class AddResourceToRoles < ActiveRecord::Migration[5.2]
  def change
    add_reference :roles, :resource, polymorphic: true
    add_index(:roles, [ :name, :resource_type, :resource_id ])
  end
end
