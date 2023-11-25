class Homeworld < ApplicationRecord
  has_many :homeworld_profiles, dependent: :destroy
  has_many :profiles, through: :homeworld_profiles
end
