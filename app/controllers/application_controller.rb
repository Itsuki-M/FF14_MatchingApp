class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login
  before_action :set_notification_object
  include NotificationsHelper

  private
  def not_authenticated
    redirect_to login_path, danger: t('defaults.message.require_login')
  end

  def set_notification_object
    @notifications = current_user.received_notifications.unread.order(created_at: :desc) if current_user
  end
end
