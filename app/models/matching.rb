class Matching < ApplicationRecord
  belongs_to :user
  belongs_to :play_content
  belongs_to :play_time

  validates :role, presence: true
  validates :data_center, presence: true

  enum role: { tank: 0, healer: 1, dps: 2 }
  enum data_center: { gaia: 0, mana: 1, elemental: 2, meteor: 3}

  def self.find_eligible_users(user_id, data_center, play_content_id, play_time_id)
    blocked_users = Block.where(blocker_user_id: user_id).pluck(:blocked_user_id)
    blocking_users = Block.where(blocked_user_id: user_id).pluck(:blocker_user_id)
    Matching.where(
      data_center: data_center, 
      play_content_id: play_content_id, 
      play_time_id: play_time_id
    )
    .where.not(
      user_id: blocked_users + blocking_users
    )
  end
  
  def self.group_users_by_role(users)
    users.group_by(&:role)
  end

  def self.form_parties(grouped_users)
    parties = []
    
    while enough_users_for_party?(grouped_users)
      party = { 'tank' => [], 'healer' => [], 'dps' => [] }
      party['tank'] = grouped_users['tank'].shift(2)
      party['healer'] = grouped_users['healer'].shift(2)
      party['dps'] = grouped_users['dps'].shift(4)
      parties << party.values.flatten if party['tank'].size == 2 && party['healer'].size == 2 && party['dps'].size == 4
    end
  
    parties
  end
  
  def self.enough_users_for_party?(grouped_users)
    grouped_users['tank'].size >= 2 && 
    grouped_users['healer'].size >= 2 && 
    grouped_users['dps'].size >= 4
  end

  def self.is_user_matched?(user_id)
    # 現在のユーザーのマッチング情報を取得
    current_user_matching = find_by(user_id: user_id)
    return false unless current_user_matching

    eligible_users = find_eligible_users(
      current_user_matching.user_id,
      current_user_matching.data_center, 
      current_user_matching.play_content_id, 
      current_user_matching.play_time_id
    )

    grouped_users = group_users_by_role(eligible_users)
    parties = form_parties(grouped_users)

    # 現在のユーザーが含まれているパーティーがあるか確認
    parties.any? { |party| party.map(&:user_id).include?(user_id) }
  end
end
