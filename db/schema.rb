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

ActiveRecord::Schema[7.1].define(version: 2024_04_21_122721) do
  create_table "buffet_registrations", force: :cascade do |t|
    t.string "trading_name"
    t.string "company_name"
    t.string "cnpj"
    t.string "phone"
    t.string "email"
    t.string "public_place"
    t.string "neighborhood"
    t.string "state"
    t.string "city"
    t.string "zip"
    t.text "description"
    t.integer "payment_method_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.string "address_number"
    t.text "complement"
    t.index ["payment_method_id"], name: "index_buffet_registrations_on_payment_method_id"
    t.index ["user_id"], name: "index_buffet_registrations_on_user_id"
  end

  create_table "event_types", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.text "description"
    t.integer "minimum_quantity"
    t.integer "maximum_quantity"
    t.integer "duration"
    t.text "menu"
    t.boolean "alcoholic_beverages"
    t.boolean "decoration"
    t.boolean "valet"
    t.boolean "insider"
    t.boolean "outsider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_event_types_on_user_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.boolean "pix"
    t.boolean "boleto"
    t.boolean "credit_card"
    t.boolean "debit_card"
    t.boolean "money"
    t.boolean "bitcoin"
    t.boolean "bank_transfer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "company"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "buffet_registrations", "payment_methods"
  add_foreign_key "buffet_registrations", "users"
  add_foreign_key "event_types", "users"
end
