class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ChatRoom.find(params[:chat_room_id])"
  end

  def speak(data)
    ChatMessage.create!(content: data['message'], chat_room_id: params[:chat_room_id], user_id: current_user.id)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
