class Api::V1::ChatsController < ApplicationController
  # before_action :get_room, only: [:create]

  def show
    chat_room = ChatRoom.find_by(id: params[:chat_room_id])

    json_response_with_serializer(chat_room, { adapter: :json, root: "chat_room" })
  end

  def create
    chats = current_user.chats.create(chat_params)
    chat_room = ChatRoom.find_by(id: chat_params[:chat_room_id])

    chats.valid? ? json_response_with_serializer(chat_room, { adapter: :json, root: "chat_room" }) : json_response({ message: chats.errors, chat_room: chat_room }, :unprocessable_entity)
  end

  def destroy
    chat = Chat.find_by(id: params[:id])

    if chat.nil?
      json_response({ message: "not found", chat_room: ChatRoom.find_by(id: params[:chat_room_id]) }, :not_found)
    else
      chat.destroy ? json_response_with_serializer(ChatRoom.find_by(id: params[:chat_room_id]), { adapter: :json, root: "chat_room" }) : json_response({ message: chat.errors, chat_room: ChatRoom.find_by(id: params[:chat_room_id]) }, :unprocessable_entity)
    end
  end

  private

    def chat_params
      params.require(:chats).permit(:content, :id, :chat_room_id)
    end

    # def get_room
    #   @chat_room = ChatRoom.find_by(id: chat_params[:chat_room_id])
    # end
end