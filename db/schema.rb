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

ActiveRecord::Schema[7.0].define(version: 2024_01_23_035643) do
  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "blocks", force: :cascade do |t|
    t.integer "blocker_user_id", null: false
    t.integer "blocked_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blocked_user_id"], name: "index_blocks_on_blocked_user_id"
    t.index ["blocker_user_id"], name: "index_blocks_on_blocker_user_id"
  end

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

  create_table "notifications", force: :cascade do |t|
    t.integer "sender_id", null: false
    t.integer "recipient_id", null: false
    t.string "notifiable_type", null: false
    t.integer "notifiable_id", null: false
    t.boolean "unread", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable"
    t.index ["recipient_id"], name: "index_notifications_on_recipient_id"
    t.index ["sender_id"], name: "index_notifications_on_sender_id"
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
    t.integer "role", default: 0, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "blocks", "users", column: "blocked_user_id"
  add_foreign_key "blocks", "users", column: "blocker_user_id"
  add_foreign_key "chat_messages", "chat_rooms"
  add_foreign_key "chat_messages", "users"
  add_foreign_key "homeworld_profiles", "homeworlds"
  add_foreign_key "homeworld_profiles", "profiles"
  add_foreign_key "job_profiles", "jobs"
  add_foreign_key "job_profiles", "profiles"
  add_foreign_key "matchings", "play_contents"
  add_foreign_key "matchings", "play_times"
  add_foreign_key "matchings", "users"
  add_foreign_key "notifications", "users", column: "recipient_id"
  add_foreign_key "notifications", "users", column: "sender_id"
  add_foreign_key "profiles", "users"
  add_foreign_key "user_chat_rooms", "chat_rooms"
  add_foreign_key "user_chat_rooms", "users"
end
