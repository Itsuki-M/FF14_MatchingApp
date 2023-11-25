class Job < ApplicationRecord
  has_many :job_profiles, dependent: :destroy
  has_many :profiles, through: :job_profiles
end
