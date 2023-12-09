class Admin::BaseController < ApplicationController
  layout 'admin/layouts/application'
  before_action :not_admin

  private

  def not_authenticated
    redirect_to admin_login_path, danger: t('defaults.message.require_login')
  end
  
  def not_admin
    redirect_to root_path, danger: t('defaults.message.require_admin') unless current_user.admin?
  end
end
