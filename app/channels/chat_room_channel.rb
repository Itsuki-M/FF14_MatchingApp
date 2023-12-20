class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_room_channel_#{params[:chat_room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = ChatMessage.create! message: data['message'], user_id: current_user.id, chat_room_id: params[:chat_room_id], send_at: Time.now
    ChatMessageBroadcastJob.perform_later(message)
  end
end
