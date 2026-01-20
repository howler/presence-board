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

ActiveRecord::Schema[8.0].define(version: 2024_01_01_000005) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "status_logs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "status_id", null: false
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status_id"], name: "index_status_logs_on_status_id"
    t.index ["user_id"], name: "index_status_logs_on_user_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "label", null: false
    t.string "color_code", null: false
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name", null: false
    t.bigint "department_id"
    t.string "avatar_url"
    t.string "role", default: "user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "current_status_id"
    t.text "current_note"
    t.index ["current_status_id"], name: "index_users_on_current_status_id"
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "status_logs", "statuses"
  add_foreign_key "status_logs", "users"
  add_foreign_key "users", "departments"
  add_foreign_key "users", "statuses", column: "current_status_id"
end
