class ChatMessage < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  before_save :set_send_at

  after_create_commit { ChatMessageBroadcastJob.perform_later(self) }

  private

  def set_send_at
    self.send_at ||= Time.current
  end
end
