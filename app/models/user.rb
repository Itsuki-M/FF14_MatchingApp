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

  has_many :user_messages, dependent: :destroy

  private
  
  def create_user_profile
    Profile.create(user_id: self.id, introduction: 'よろしくお願いします！', active_time: 0)
  end
end
