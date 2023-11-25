class ProfilesController < ApplicationController
  def show
    @profile = Profile.find(params[:id])
    @main_job = @profile.jobs.first || '特になし'
    @main_world = @profile.homeworlds.first || '特になし'
  end

  def edit
  end

  def update
  end
end
