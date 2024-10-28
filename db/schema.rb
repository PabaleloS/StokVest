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

ActiveRecord::Schema[7.1].define(version: 2024_10_25_100639) do
  create_table "contributions", force: :cascade do |t|
    t.decimal "amount"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "stokvel_id"
    t.integer "member_id"
    t.date "date"
    t.decimal "contribution_amount"
    t.integer "status", default: 0
    t.string "payment_method"
    t.index ["user_id"], name: "index_contributions_on_user_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.decimal "contribution"
    t.date "join_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.integer "user_id"
    t.integer "stokvel_id"
    t.integer "balance"
    t.string "first_name"
    t.date "next_withdrawal_date"
    t.datetime "last_payout_date"
    t.decimal "last_payout_amount"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.integer "stokvel_id", null: false
    t.integer "member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_messages_on_member_id"
    t.index ["stokvel_id"], name: "index_messages_on_stokvel_id"
  end

  create_table "payouts", force: :cascade do |t|
    t.decimal "amount"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "stokvel_id"
    t.integer "member_id", null: false
    t.date "date"
    t.index ["member_id"], name: "index_payouts_on_member_id"
    t.index ["stokvel_id"], name: "index_payouts_on_stokvel_id"
    t.index ["user_id"], name: "index_payouts_on_user_id"
  end

  create_table "stokvels", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "contribution_amount"
    t.integer "contribution_frequency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.decimal "balance"
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "amount"
    t.date "date"
    t.integer "member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "transaction_type"
    t.integer "stokvel_id"
    t.index ["member_id"], name: "index_transactions_on_member_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.decimal "balance", precision: 10, scale: 2, default: "0.0"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "contributions", "users"
  add_foreign_key "messages", "members"
  add_foreign_key "messages", "stokvels"
  add_foreign_key "payouts", "members"
  add_foreign_key "payouts", "stokvels"
  add_foreign_key "payouts", "users"
  add_foreign_key "transactions", "members"
end
