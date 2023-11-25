class CreateHomeworldProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :homeworld_profiles do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :homeworld, null: false, foreign_key: true

      t.timestamps
    end
  end
end
