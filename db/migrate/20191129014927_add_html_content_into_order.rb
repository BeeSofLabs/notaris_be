class AddHtmlContentIntoOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :html_content, :string, default: ""
  end
end
