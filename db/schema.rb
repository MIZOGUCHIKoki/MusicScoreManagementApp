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

ActiveRecord::Schema[7.1].define(version: 2023_12_08_021527) do
  create_table "scores", force: :cascade do |t|
    t.text "name"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "piccolo", default: 0, null: false
    t.integer "c_fulte", default: 0, null: false
    t.integer "oboe", default: 0, null: false
    t.integer "english_holn", default: 0, null: false
    t.integer "b_clarinet", default: 0, null: false
    t.integer "b_bass_clarinet", default: 0, null: false
    t.integer "bassoon", default: 0, null: false
    t.integer "e_alto_saxophone", default: 0, null: false
    t.integer "b_tenor_saxophone", default: 0, null: false
    t.integer "b_baritone_saxophone", default: 0, null: false
    t.integer "b_trumpet", default: 0, null: false
    t.integer "f_horn", default: 0, null: false
    t.integer "trombone", default: 0, null: false
    t.integer "euphonium", default: 0, null: false
    t.integer "tuba", default: 0, null: false
    t.integer "string_bass", default: 0, null: false
    t.integer "eb", default: 0, null: false
    t.integer "piano", default: 0, null: false
    t.integer "timpani", default: 0, null: false
    t.integer "drums", default: 0, null: false
    t.integer "percussion", default: 0, null: false
    t.index ["user_id", "created_at"], name: "index_scores_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_scores_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "scores", "users"
end
