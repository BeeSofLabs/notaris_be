class AddValidateSearchNotarisCountIntoUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :valid_count_search_notaris, :integer, default: 0
  end
end
