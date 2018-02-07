# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180207225847) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "guides", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "image"
    t.string "file"
    t.bigint "lens_shifter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tags"
    t.string "slug"
    t.index ["lens_shifter_id"], name: "index_guides_on_lens_shifter_id"
  end

  create_table "lens_shifter_profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "birthdate"
    t.string "ethnicity"
    t.string "location"
    t.float "latitude"
    t.float "longitude"
    t.string "sector"
    t.text "referral"
    t.text "comment"
    t.boolean "contact_consent"
    t.bigint "lens_shifter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.index ["lens_shifter_id"], name: "index_lens_shifter_profiles_on_lens_shifter_id"
  end

  create_table "lens_shifters", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["admin"], name: "index_lens_shifters_on_admin"
    t.index ["confirmation_token"], name: "index_lens_shifters_on_confirmation_token", unique: true
    t.index ["email"], name: "index_lens_shifters_on_email", unique: true
    t.index ["reset_password_token"], name: "index_lens_shifters_on_reset_password_token", unique: true
  end

  create_table "lessons", force: :cascade do |t|
    t.string "title"
    t.text "analysis"
    t.bigint "stream_id"
    t.integer "row_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stream_id"], name: "index_lessons_on_stream_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "birthdate"
    t.string "ethnicity"
    t.string "location"
    t.float "latitude"
    t.float "longitude"
    t.string "sector"
    t.text "referral"
    t.text "comment"
    t.boolean "contact_consent"
    t.bigint "lens_shifter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.jsonb "address"
    t.index "((address -> 'country'::text))", name: "index_profiles_on_address_city", using: :gin
    t.index ["lens_shifter_id"], name: "index_profiles_on_lens_shifter_id"
  end

  create_table "resource_items", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.string "source_url"
    t.integer "estimated_reading_time"
    t.text "short_summary"
    t.string "tags"
    t.text "key_takeaways"
    t.text "analysis_content"
    t.string "image"
    t.string "resource_type"
    t.string "slug"
    t.datetime "published_at"
    t.boolean "feature"
    t.integer "google_doc_id"
    t.bigint "lens_shifter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "article_date"
    t.string "article_title"
    t.text "article_desc"
    t.text "article_content"
    t.text "video_embed"
    t.index ["lens_shifter_id"], name: "index_resource_items_on_lens_shifter_id"
    t.index ["slug"], name: "index_resource_items_on_slug"
  end

  create_table "streams", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "estimated_reading_time"
    t.text "guiding_questions"
    t.string "tags"
    t.string "slug"
    t.string "image"
    t.bigint "lens_shifter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lens_shifter_id"], name: "index_streams_on_lens_shifter_id"
  end

  create_table "syllabuses", force: :cascade do |t|
    t.integer "row_order"
    t.bigint "lesson_id"
    t.bigint "resource_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_syllabuses_on_lesson_id"
    t.index ["resource_item_id"], name: "index_syllabuses_on_resource_item_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  add_foreign_key "guides", "lens_shifters"
  add_foreign_key "lens_shifter_profiles", "lens_shifters"
  add_foreign_key "lessons", "streams"
  add_foreign_key "profiles", "lens_shifters"
  add_foreign_key "resource_items", "lens_shifters"
  add_foreign_key "streams", "lens_shifters"
  add_foreign_key "syllabuses", "lessons"
  add_foreign_key "syllabuses", "resource_items"
end
