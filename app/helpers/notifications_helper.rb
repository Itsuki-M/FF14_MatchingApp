module NotificationsHelper
  def generate_notification_message(notification)
    return unless notification
    
    case notification.notifiable_type
    when 'ChatRoom'
      "マッチングしました"
    else
      "通知メッセージ"
    end
  end
end