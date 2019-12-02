class AddDocFileNameIntoOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :doc_filename, :string
  end
end
