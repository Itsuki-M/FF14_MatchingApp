class CreateJobProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :job_profiles do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end
