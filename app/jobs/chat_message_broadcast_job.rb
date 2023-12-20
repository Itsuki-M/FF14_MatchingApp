class ChatMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    broadcast_data = {
      message: render_message(message),
      second_message: render_second_message(message),
      user_id: message.user_id
    }
    ActionCable.server.broadcast "chat_room_channel_#{message.chat_room_id}", broadcast_data
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'chat_messages/my_chat_message', locals: { chat_message: message })
  end

  def render_second_message(message)
    ApplicationController.renderer.render(partial: 'chat_messages/other_chat_message', locals: { chat_message: message})
  end
end
