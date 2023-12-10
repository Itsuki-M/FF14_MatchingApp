class Admin::UsersController < Admin::BaseController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, success: t('.success')
    else
      render :edit, danger: t('.danger')
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path, success: t('.success')
    else
      redirect_to admin_users_path, danger: t('.danger')
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :role)
  end
end
