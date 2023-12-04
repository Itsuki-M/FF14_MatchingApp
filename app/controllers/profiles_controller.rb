class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update]
  def show
    @main_job = @profile.jobs.last || '特になし'
    @main_world = @profile.homeworlds.last || '特になし'
  end

  def edit
    unless @profile.user == current_user
      redirect_to root_path, danger: t('.danger')
    end
    @user = @profile.user
    @profile.job_profiles.build if @profile.job_profiles.empty?
    @profile.homeworld_profiles.build if @profile.homeworld_profiles.empty?
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path(@profile), success: t('.success')
    else
      render :edit, danger: t('.fail')
    end
  end

  private
  
  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:avatar, :avatar_cache, :introduction, :active_time, 
    user_attributes: [:id, :name],
    job_profiles_attributes: [:id, :job_id, :profile_id, :_destroy] , 
    homeworld_profiles_attributes: [:id, :homeworld_id, :profile_id, :_destroy])
  end
end
