class BlocksController < ApplicationController
  def confirm
    @user_to_block = User.find(params[:blocked_user_id])
    if current_user.blocker_blocks.find_by(blocked_user_id: @user_to_block.id)
      redirect_to profile_path(@user_to_block.profile), warning: t('.warning')
    end
  end

  def create
    @user = User.find(params[:blocked_user_id])
    block = current_user.blocker_blocks.create(blocked_user_id: @user.id)
  
    if block.persisted?
      redirect_to profile_path(@user.profile), success: t('.success')
    else
      redirect_to profile_path(@user.profile), danger: t('.danger')
    end
  end
  

  def destroy
    @block = Block.find(params[:id])
    if @block.destroy
      redirect_to profile_path(@block.blocked_user.profile), success: t('.success')
    else
      redirect_to profile_path(@block.blocked_user.profile), danger: t('.danger')
    end
  end
end
