class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to root_path, success: t('.success')
    else
      render :new, danger: t('.fail')
    end
  end

  def destroy
    logout
    redirect_to root_path, success: t('.success')
  end
end
