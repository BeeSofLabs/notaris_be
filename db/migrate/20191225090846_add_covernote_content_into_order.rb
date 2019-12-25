class AddCovernoteContentIntoOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :covernote_content, :string, default: ""
  end
end
