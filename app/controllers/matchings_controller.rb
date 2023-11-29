class MatchingsController < ApplicationController
  def new
    @matching = Matching.new
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
    @matching = current_user.matching
    unless @matching
      redirect_to new_matching_path, warning: t('.warning')
    end
  end

  def edit
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
    if @matching.destroy
      redirect_to new_matching_path, success: t('.success')
    else
      redirect_to matching_path(@matching), danger: t('.danger')
    end
  end

  private
  def matching_params
    params.require(:matching).permit(:role, :data_center, :play_content_id, :play_time_id)
  end
end
