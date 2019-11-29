class ChatSerializer < ActiveModel::Serializer
  attributes :id, :chat_room_id, :user_id, :content, :created_at, :username

  def username
    object.user.try(:name)
  end
end

class ChatRoomSerializer < ActiveModel::Serializer
  attributes  :id, :close_date, :is_closed, :open_date, :order_id

  has_many  :chats, serializer: ChatSerializer
end
