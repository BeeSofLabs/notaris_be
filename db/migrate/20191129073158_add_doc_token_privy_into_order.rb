class AddDocTokenPrivyIntoOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :doc_token_privy, :string
  end
end
