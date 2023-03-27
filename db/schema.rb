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

ActiveRecord::Schema[7.0].define(version: 2023_03_27_130031) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.string "num_of_employees"
    t.bigint "industry_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["industry_id"], name: "index_businesses_on_industry_id"
    t.index ["user_id"], name: "index_businesses_on_user_id"
  end

  create_table "channels", force: :cascade do |t|
    t.string "name"
    t.bigint "business_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_channels_on_business_id"
    t.index ["user_id"], name: "index_channels_on_user_id"
  end

  create_table "goals", force: :cascade do |t|
    t.string "quater_name"
    t.string "projected_leads"
    t.float "budget"
    t.float "projected_conversion_rate"
    t.float "projected_revenue"
    t.string "channels"
    t.bigint "user_id", null: false
    t.bigint "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_goals_on_business_id"
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "industries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.bigint "business_id", null: false
    t.bigint "user_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_products_on_business_id"
    t.index ["user_id"], name: "index_products_on_user_id"
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
    t.string "phone_number"
    t.string "title"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weekly_data_entries", force: :cascade do |t|
    t.bigint "goal_id", null: false
    t.bigint "business_id", null: false
    t.bigint "user_id", null: false
    t.integer "leads_per_week"
    t.integer "contacted_leads"
    t.string "paid_customers"
    t.float "budget_expences"
    t.float "revenue"
    t.float "conversion_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "channel_leads_per_week", default: [], array: true
    t.date "date"
    t.text "product_leads_per_week", default: [], array: true
    t.index ["business_id"], name: "index_weekly_data_entries_on_business_id"
    t.index ["goal_id"], name: "index_weekly_data_entries_on_goal_id"
    t.index ["user_id"], name: "index_weekly_data_entries_on_user_id"
  end

  add_foreign_key "businesses", "industries"
  add_foreign_key "businesses", "users"
  add_foreign_key "channels", "businesses"
  add_foreign_key "channels", "users"
  add_foreign_key "goals", "businesses"
  add_foreign_key "goals", "users"
  add_foreign_key "products", "businesses"
  add_foreign_key "products", "users"
  add_foreign_key "weekly_data_entries", "businesses"
  add_foreign_key "weekly_data_entries", "goals"
  add_foreign_key "weekly_data_entries", "users"
end
