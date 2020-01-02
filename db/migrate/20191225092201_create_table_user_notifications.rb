class CreateTableUserNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :action_type
      t.string  :title
      t.string  :description
      t.string  :url_action

      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
