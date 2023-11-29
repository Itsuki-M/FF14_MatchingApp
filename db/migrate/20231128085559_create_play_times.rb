class CreatePlayTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :play_times do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
