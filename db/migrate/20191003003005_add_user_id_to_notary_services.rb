class AddUserIdToNotaryServices < ActiveRecord::Migration[5.2]
  def change
    add_column :notary_services, :user_id, :integer
    add_index :notary_services, :user_id
  end
end
