class CreatePlayContents < ActiveRecord::Migration[7.0]
  def change
    create_table :play_contents do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
