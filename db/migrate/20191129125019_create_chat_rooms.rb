class CreateChatRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_rooms do |t|
      t.references :order, foreign_key: true
      t.date :open_date
      t.date :close_date
      t.boolean :is_closed, default: false

      t.timestamps
    end
  end
end
