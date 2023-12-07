class PartysController < ApplicationController
  def index
    # 条件に合うユーザーを取得
    eligible_users = Matching.find_eligible_users(
      current_user.matching.data_center, 
      current_user.matching.play_content_id, 
      current_user.matching.play_time_id
    )

    # ユーザーをロール別にグループ化
    grouped_users = Matching.group_users_by_role(eligible_users)

    # パーティーを形成
    parties = Matching.form_parties(grouped_users)

    # 現在のユーザーが含まれているパーティーを検索
    @party_members = parties.find { |party| party.map(&:user_id).include?(current_user.id) }

    if @party_members
      # 役割ごとのメンバー分割
      @tanks = @party_members.select { |member| member.role == 'tank' }
      @healers = @party_members.select { |member| member.role == 'healer' }
      @dpses = @party_members.select { |member| member.role == 'dps' }

      party_id = generate_unique_party_id(current_user.matching)

      @chat_room = ChatRoom.find_or_create_by(party_id: party_id) do |chat_room|
        # パーティーメンバーをチャットルームに割り当てる
        @party_members.each do |member|
          chat_room.user_chat_rooms.build(user_id: member.user_id)
        end
      end
    else
      # パーティーメンバーが見つからない場合の処理
      redirect_to matching_path(current_user.matching), warning: t('.warning')
    end
  end

  def detail
    # 条件に合うユーザーを取得
    eligible_users = Matching.find_eligible_users(
      current_user.matching.data_center, 
      current_user.matching.play_content_id, 
      current_user.matching.play_time_id
    )

    # ユーザーをロール別にグループ化
    grouped_users = Matching.group_users_by_role(eligible_users)

    # パーティーを形成
    parties = Matching.form_parties(grouped_users)

    # 現在のユーザーが含まれているパーティーを検索
    @party_members = parties.find { |party| party.map(&:user_id).include?(current_user.id) }

    party_id = generate_unique_party_id(current_user.matching)
    @chat_room = ChatRoom.find_by(party_id: party_id)

    unless @party_members
      redirect_to matching_path(current_user.matching), warning: t('.warning')
    end
  end

  private

  def generate_unique_party_id(matching)
    info = [matching.data_center, matching.play_content_id, matching.play_time_id].join("-")
    Digest::SHA1.hexdigest(info)
  end
end
