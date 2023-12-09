class Admin::UserSessionsController < Admin::BaseController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :not_admin, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to admin_root_path, success: t('.success')
    else
      render :new, danger: t('.fail')
    end
  end

  def destroy
    logout
    redirect_to admin_login_path, success: t('.success')
  end
end
