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

ActiveRecord::Schema[7.0].define(version: 2025_05_11_121024) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text "explanation", null: false
    t.integer "good_prop", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "lexicon_answers", force: :cascade do |t|
    t.integer "good_prop", null: false
    t.bigint "lexicon_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lexicon_id"], name: "index_lexicon_answers_on_lexicon_id"
  end

  create_table "lexicon_results", force: :cascade do |t|
    t.integer "score"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lexicon_results_on_user_id"
  end

  create_table "lexicons", force: :cascade do |t|
    t.text "statement", null: false
    t.text "prop_one", null: false
    t.text "prop_two", null: false
    t.text "prop_three", null: false
    t.integer "category", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lexicons_results", force: :cascade do |t|
    t.integer "score", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lexicons_results_on_user_id"
  end

  create_table "missed_questions", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.index ["user_id", "question_id"], name: "index_missed_questions_on_user_id_and_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "statement", null: false
    t.text "prop_one", null: false
    t.text "prop_two", null: false
    t.text "prop_three", null: false
    t.integer "level", null: false
    t.integer "category", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "lexicon_answers", "lexicons"
  add_foreign_key "lexicon_results", "users"
  add_foreign_key "lexicons_results", "users"
  add_foreign_key "questions", "users"
end
