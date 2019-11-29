class AddUrlDocumentPrivyIntoOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :url_document_privy, :string
  end
end
