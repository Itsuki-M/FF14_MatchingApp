class ChatMessage < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  validates :message, presence: true

  before_save :set_send_at

  private

  def set_send_at
    self.send_at ||= Time.current
  end
end
