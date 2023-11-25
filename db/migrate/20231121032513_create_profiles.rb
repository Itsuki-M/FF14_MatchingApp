class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :avatar
      t.text :introduction
      t.integer :active_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
