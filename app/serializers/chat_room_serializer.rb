# == Schema Information
#
# Table name: chat_rooms
#
#  id         :bigint(8)        not null, primary key
#  close_date :date
#  is_closed  :boolean          default(FALSE)
#  open_date  :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint(8)
#
# Indexes
#
#  index_chat_rooms_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#

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
