class User < ApplicationRecord
  authenticates_with_sorcery!

  after_create :create_user_profile

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  validates :name, presence: true, length: { maximum: 255 }

  has_one :profile, dependent: :destroy

  has_one :matching, dependent: :destroy

  has_many :user_chat_rooms, dependent: :destroy
  has_many :chat_rooms, through: :user_chat_rooms

  has_many :chat_messages, dependent: :destroy

  has_many :blocker_blocks, class_name: 'Block', foreign_key: 'blocker_user_id'
  has_many :blocked_blocks, class_name: 'Block', foreign_key: 'blocked_user_id'

  has_many :sent_notifications, class_name: 'Notification', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_notifications, class_name: 'Notification', foreign_key: 'recipient_id', dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  enum role: { general: 0, admin: 1 }

  def self.ransackable_attributes(auth_object = nil)
    %w[name email]
  end

  private
  
  def create_user_profile
    Profile.create(user_id: self.id, introduction: 'よろしくお願いします！', active_time: 0)
  end
end
