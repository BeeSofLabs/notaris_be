class AddPrivyTokenToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :privy_token, :string
  end
end
