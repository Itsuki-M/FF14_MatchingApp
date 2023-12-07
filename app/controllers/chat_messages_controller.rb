class ChatMessagesController < ApplicationController
  before_action :set_chat_room

  def create
    @chat_message = @chat_room.chat_messages.new(chat_message_params.merge(user_id: current_user.id))
    if @chat_message.save
      # メッセージの保存に成功した場合の処理
      redirect_to @chat_room
    else
      # 保存に失敗した場合の処理
      redirect_to @chat_room, warning: t('.warning')
    end
  end

  private

  def set_chat_room
    @chat_room = ChatRoom.find(params[:chat_room_id])
  end

  def chat_message_params
    params.require(:chat_message).permit(:message)
  end
end

