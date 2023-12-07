class ChatRoom < ApplicationRecord
  has_many :user_chat_rooms, dependent: :destroy
  has_many :users, through: :user_chat_rooms

  has_many :chat_messages, dependent: :destroy

  validates :party_id, presence: true, uniqueness: true

  def self.assign_party_to_chat_room(party_members)
    chat_room = ChatRoom.create! # 新しいチャットルームのインスタンスを作成

    # チャットルームにパーティーメンバーを割り当てるロジック
    party_members.each do |member|
      # 例: UserChatRoom を使用してユーザーとチャットルームを関連付ける
      UserChatRoom.create!(user_id: member.user_id, chat_room_id: chat_room.id)
    end

    chat_room
  end
end
