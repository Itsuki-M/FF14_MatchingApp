class Profile < ApplicationRecord
  belongs_to :user
  mount_uploader :avatar, UserAvatarUploader

  has_many :job_profiles, dependent: :destroy
  has_many :jobs, through: :job_profiles

  has_many :homeworld_profiles, dependent: :destroy
  has_many :homeworlds, through: :homeworld_profiles

  enum active_time: { '0~3時': 0, '3~6時': 1, '6~9時': 2, '9~12時': 3, '12~15時': 4, '15~18時': 5, '18~21時': 6, '21~24時': 7 }
end
