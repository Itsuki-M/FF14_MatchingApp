class Block < ApplicationRecord
  belongs_to :blocker_user, class_name: 'User'
  belongs_to :blocked_user, class_name: 'User'
end
