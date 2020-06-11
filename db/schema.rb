# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_31_160130) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.integer "commentable_id", null: false
    t.string "commentable_type", null: false
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.string "ancestry"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ancestry"], name: "index_comments_on_ancestry"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "email", null: false
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_companies_on_email", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "anchor", null: false
    t.integer "duration", default: 1440, null: false
    t.integer "frequency", default: 0, null: false
    t.string "color", limit: 9, default: "#0000ff", null: false
    t.integer "ticket_id"
    t.integer "user_id"
    t.integer "unit_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string "user_full_name"
    t.string "email"
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "noticeable_id", null: false
    t.string "noticeable_type", null: false
    t.bigint "user_id", null: false
    t.integer "notified_by_id", null: false
    t.boolean "read", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating", null: false
    t.text "comment", null: false
    t.bigint "ticket_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ticket_id"], name: "index_reviews_on_ticket_id", unique: true
  end

  create_table "tickets", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.bigint "unit_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0, null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_tickets_on_ancestry"
    t.index ["unit_id"], name: "index_tickets_on_unit_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "company_id"
    t.string "ancestry"
    t.integer "responsible_user_id"
    t.index ["ancestry"], name: "index_units_on_ancestry"
    t.index ["company_id"], name: "index_units_on_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role", default: 0, null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_companies_relationships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_users_companies_relationships_on_company_id"
    t.index ["user_id", "company_id"], name: "relationship_index", unique: true
    t.index ["user_id"], name: "index_users_companies_relationships_on_user_id"
  end

  create_table "users_units_relationships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "unit_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["unit_id"], name: "index_users_units_relationships_on_unit_id"
    t.index ["user_id", "unit_id"], name: "index_users_units_rel", unique: true
    t.index ["user_id"], name: "index_users_units_relationships_on_user_id"
  end

  create_table "watchers_relationships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "ticket_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ticket_id"], name: "index_watchers_relationships_on_ticket_id"
    t.index ["user_id"], name: "index_watchers_relationships_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "users"
  add_foreign_key "events", "tickets"
  add_foreign_key "events", "units"
  add_foreign_key "events", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "users", column: "notified_by_id"
  add_foreign_key "reviews", "tickets"
  add_foreign_key "tickets", "units"
  add_foreign_key "tickets", "users"
  add_foreign_key "units", "companies"
  add_foreign_key "units", "users", column: "responsible_user_id"
  add_foreign_key "users_companies_relationships", "companies"
  add_foreign_key "users_companies_relationships", "users"
  add_foreign_key "users_units_relationships", "units"
  add_foreign_key "users_units_relationships", "users"
end
