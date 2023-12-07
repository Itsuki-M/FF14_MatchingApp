class MatchingsController < ApplicationController
  def new
    if Matching.is_user_matched?(current_user.id)
      redirect_to partys_path, warning: t('.already_matched')
      return
    end
    if current_user.matching.present?
      redirect_to matching_path(current_user.matching), warning: t('.warning')
    else
      @matching = Matching.new
    end
  end

  def create
    @matching = current_user.build_matching(matching_params)
    if @matching.save
      redirect_to matching_path(@matching), success: t('.success')
    else
      render 'new', danger: t('.danger')
    end
  end

  def show
    if Matching.is_user_matched?(current_user.id)
      redirect_to partys_path, warning: t('.already_matched')
      return
    end
    @matching = current_user.matching
    unless @matching
      redirect_to new_matching_path, warning: t('.warning')
    end
  end

  def edit
    if Matching.is_user_matched?(current_user.id)
      redirect_to partys_path, warning: t('.already_matched')
      return
    end
    @matching = current_user.matching
  end

  def update
    @matching = current_user.matching
    if @matching.update(matching_params)
      redirect_to matching_path(@matching), success: t('.success')
    else
      render 'edit', danger: t('.danger')
    end
    
  end

  def destroy
    @matching = current_user.matching
    if @matching
      chat_room = ChatRoom.joins(:user_chat_rooms).where('user_chat_rooms.user_id = ?', current_user.id)
      chat_room.each(&:destroy)
      
      if @matching.destroy
        redirect_to new_matching_path, success: t('.success')
      else
        redirect_to matching_path(@matching), danger: t('.danger')
      end
    end
    
  end

  private
  def matching_params
    params.require(:matching).permit(:role, :data_center, :play_content_id, :play_time_id)
  end
end
