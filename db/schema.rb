# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_12_05_114344) do
  create_table "chat_messages", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "chat_room_id", null: false
    t.text "message", null: false
    t.datetime "send_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_room_id"], name: "index_chat_messages_on_chat_room_id"
    t.index ["user_id"], name: "index_chat_messages_on_user_id"
  end

  create_table "chat_rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "party_id"
  end

  create_table "homeworld_profiles", force: :cascade do |t|
    t.integer "profile_id", null: false
    t.integer "homeworld_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["homeworld_id"], name: "index_homeworld_profiles_on_homeworld_id"
    t.index ["profile_id"], name: "index_homeworld_profiles_on_profile_id"
  end

  create_table "homeworlds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_profiles", force: :cascade do |t|
    t.integer "profile_id", null: false
    t.integer "job_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_profiles_on_job_id"
    t.index ["profile_id"], name: "index_job_profiles_on_profile_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matchings", force: :cascade do |t|
    t.integer "role", null: false
    t.integer "data_center", null: false
    t.integer "user_id", null: false
    t.integer "play_content_id", null: false
    t.integer "play_time_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["play_content_id"], name: "index_matchings_on_play_content_id"
    t.index ["play_time_id"], name: "index_matchings_on_play_time_id"
    t.index ["user_id"], name: "index_matchings_on_user_id"
  end

  create_table "play_contents", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "play_times", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "avatar"
    t.text "introduction"
    t.integer "active_time"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "user_chat_rooms", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "chat_room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_room_id"], name: "index_user_chat_rooms_on_chat_room_id"
    t.index ["user_id"], name: "index_user_chat_rooms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "chat_messages", "chat_rooms"
  add_foreign_key "chat_messages", "users"
  add_foreign_key "homeworld_profiles", "homeworlds"
  add_foreign_key "homeworld_profiles", "profiles"
  add_foreign_key "job_profiles", "jobs"
  add_foreign_key "job_profiles", "profiles"
  add_foreign_key "matchings", "play_contents"
  add_foreign_key "matchings", "play_times"
  add_foreign_key "matchings", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "user_chat_rooms", "chat_rooms"
  add_foreign_key "user_chat_rooms", "users"
end
