class CreateTableUserNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :table_user_notifications do |t|
      t.string  :title,
      t.string  :action,
      t.string  

      t.timestamps
    end
  end
end
