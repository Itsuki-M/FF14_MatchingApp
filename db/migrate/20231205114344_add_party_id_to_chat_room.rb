class AddPartyIdToChatRoom < ActiveRecord::Migration[7.0]
  def change
    add_column :chat_rooms, :party_id, :string
  end
end
