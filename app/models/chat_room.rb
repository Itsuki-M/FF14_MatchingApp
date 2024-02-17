class ChatRoom < ApplicationRecord
  has_many :user_chat_rooms, dependent: :destroy
  has_many :users, through: :user_chat_rooms

  has_many :chat_messages, dependent: :destroy

  validates :party_id, presence: true, uniqueness: true

  after_create_commit :create_notification

  before_destroy :destroy_notification

  def self.assign_party_to_chat_room(party_members)
    chat_room = ChatRoom.create! # 新しいチャットルームのインスタンスを作成

    # チャットルームにパーティーメンバーを割り当てるロジック
    party_members.each do |member|
      # 例: UserChatRoom を使用してユーザーとチャットルームを関連付ける
      UserChatRoom.create!(user_id: member.user_id, chat_room_id: chat_room.id)
    end

    chat_room
  end

  private

  def create_notification
    sender_id = Rails.application.config.admin_user_id
    recipient_ids = users.pluck(:id)

    recipient_ids.each do |recipient_id|
      Notification.create!(sender_id: sender_id, recipient_id: recipient_id, notifiable: self)
    end

    users.each do |user|
      if valid_user_for_nortification?(user)
        send_line_message(user.email, "マッチングしました! チャットでメンバーと話し合おう! https://www.ff14matching.com")
      end
    end
  end

  def destroy_notification
    Notification.where(notifiable: self).destroy_all
  end

  def valid_user_for_nortification?(user)
    user.email.present? &&
      user.email.start_with?('U') &&
      user.email.length == 33 &&
      user.email.exclude?('@')
  end

  def send_line_message(user_id, message)
    message = {
      type: 'text',
      text: message
    }
    client = Rails.application.config.line_bot_client
    response = client.push_message(user_id, message)
    puts response
  end
end
