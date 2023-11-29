class Matching < ApplicationRecord
  belongs_to :user
  belongs_to :play_content
  belongs_to :play_time

  validates :role, presence: true
  validates :data_center, presence: true

  enum role: { tank: 0, healer: 1, dps: 2 }
  enum data_center: { gaia: 0, mana: 1, elemental: 2, meteor: 3}
end
