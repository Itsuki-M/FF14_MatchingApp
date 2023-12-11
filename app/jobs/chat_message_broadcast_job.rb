class ChatMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(chat_message)
    ActionCable.server.broadcast "chat_room_#{chat_message.chat_room_id}", 
                                message: render_message(chat_message)
  end

  private

  def render_message(chat_message)
    ApplicationController.renderer.render(partial: 'chat_messages/chat_message', locals: { chat_message: chat_message })
  end
end
