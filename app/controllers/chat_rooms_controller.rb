class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: [:show]
  def show
    if Matching.is_user_matched?(current_user.id)
      @messages = @chat_room.chat_messages.includes(:user).order(created_at: :desc).page(params[:page]).per(50)
    else
      redirect_to root_path, warning: t('.warning')
    end
  end

  private

  def set_chat_room
    @chat_room = ChatRoom.find(params[:id])
  end
end
