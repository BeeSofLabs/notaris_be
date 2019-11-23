class AddDocumentTypeIntoOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :document_type, :string, :after => :is_deleted
  end
end
