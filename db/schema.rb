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

ActiveRecord::Schema[7.1].define(version: 2024_04_28_225314) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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

  create_table "client_data", force: :cascade do |t|
    t.string "cpf"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_client_data_on_user_id"
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
    t.integer "buffet_registration_id", null: false
    t.integer "working_day_price_id"
    t.integer "weekend_price_id"
    t.boolean "different_weekend"
    t.index ["buffet_registration_id"], name: "index_event_types_on_buffet_registration_id"
    t.index ["user_id"], name: "index_event_types_on_user_id"
    t.index ["weekend_price_id"], name: "index_event_types_on_weekend_price_id"
    t.index ["working_day_price_id"], name: "index_event_types_on_working_day_price_id"
  end

  create_table "event_values", force: :cascade do |t|
    t.float "base_price"
    t.float "price_per_person"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "overtime_rate"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "buffet_registrations", "payment_methods"
  add_foreign_key "buffet_registrations", "users"
  add_foreign_key "client_data", "users"
  add_foreign_key "event_types", "buffet_registrations"
  add_foreign_key "event_types", "event_values", column: "weekend_price_id"
  add_foreign_key "event_types", "event_values", column: "working_day_price_id"
  add_foreign_key "event_types", "users"
end
