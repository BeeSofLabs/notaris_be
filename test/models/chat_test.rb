# == Schema Information
#
# Table name: chats
#
#  id           :bigint(8)        not null, primary key
#  content      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  chat_room_id :bigint(8)
#  user_id      :bigint(8)
#
# Indexes
#
#  index_chats_on_chat_room_id  (chat_room_id)
#  index_chats_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (chat_room_id => chat_rooms.id)
#  fk_rails_...  (user_id => users.id)
#

require 'test_helper'

class ChatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
