class MatchingsController < ApplicationController
  def new
    @matching = Matching.new
  end

  def create
    @matching = current_user.build_matching(matching_params)
    if @matching.save
      redirect_to root_path, success: t('.success')
    else
      render 'new', danger: t('.danger')
    end
  end

  private
  def matching_params
    params.require(:matching).permit(:role, :data_center, :play_content_id, :play_time_id)
  end
end
