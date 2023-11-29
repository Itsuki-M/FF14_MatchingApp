class CreateMatchings < ActiveRecord::Migration[7.0]
  def change
    create_table :matchings do |t|
      t.integer :role, null: false
      t.integer :data_center, null: false
      t.references :user, null: false, foreign_key: true
      t.references :play_content, null: false, foreign_key: true
      t.references :play_time, null: false, foreign_key: true

      t.timestamps
    end
  end
end
