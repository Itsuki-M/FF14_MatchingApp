class CreateBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :blocks do |t|
      t.references :blocker_user, null: false, foreign_key: { to_table: :users }
      t.references :blocked_user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
