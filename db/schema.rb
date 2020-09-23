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

ActiveRecord::Schema.define(version: 2020_09_23_100356) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "calls", id: :serial, force: :cascade do |t|
    t.string "username"
    t.string "userphone"
    t.text "messangers", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.string "city"
    t.string "event"
    t.string "person"
    t.string "budget"
    t.string "desc"
    t.string "call_type"
    t.string "sms_status"
    t.datetime "sms_sent_at"
    t.string "email_status"
    t.datetime "email_sent_at"
  end

  create_table "carts", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "total"
    t.integer "used_code_discount", default: 0
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "desc"
    t.string "img_file_name"
    t.string "img_content_type"
    t.bigint "img_file_size"
    t.datetime "img_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "colors", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "compositions", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "img_file_name"
    t.string "img_content_type"
    t.bigint "img_file_size"
    t.datetime "img_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "deleted", default: false
    t.float "price", default: 0.0
    t.integer "views", default: 0
  end

  create_table "compositions_receivers", id: false, force: :cascade do |t|
    t.integer "composition_id"
    t.integer "receiver_id"
    t.index ["composition_id", "receiver_id"], name: "index_compositions_receivers_on_composition_id_and_receiver_id"
  end

  create_table "compositions_tags", id: false, force: :cascade do |t|
    t.integer "composition_id"
    t.integer "tag_id"
    t.index ["composition_id", "tag_id"], name: "index_compositions_tags_on_composition_id_and_tag_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "feedbacks", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.string "img_file_name"
    t.string "img_content_type"
    t.bigint "img_file_size"
    t.datetime "img_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.string "social_url"
    t.string "promocode"
  end

  create_table "foil_forms", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
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

  create_table "images", id: :serial, force: :cascade do |t|
    t.string "img_file_name"
    t.string "img_content_type"
    t.bigint "img_file_size"
    t.datetime "img_updated_at"
    t.string "imageable_type"
    t.integer "imageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "style"
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id"
  end

  create_table "items", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "item_type"
    t.boolean "deleted", default: false
    t.integer "vendor_id"
    t.integer "tone_id"
    t.integer "texture_id"
    t.integer "category_id"
    t.integer "type_id"
    t.integer "color_id"
    t.integer "foil_form_id"
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["color_id"], name: "index_items_on_color_id"
    t.index ["foil_form_id"], name: "index_items_on_foil_form_id"
    t.index ["texture_id"], name: "index_items_on_texture_id"
    t.index ["tone_id"], name: "index_items_on_tone_id"
    t.index ["type_id"], name: "index_items_on_type_id"
    t.index ["vendor_id"], name: "index_items_on_vendor_id"
  end

  create_table "items_in_compositions", id: :serial, force: :cascade do |t|
    t.integer "item_id"
    t.integer "composition_id"
    t.integer "items_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id"
    t.index ["composition_id"], name: "index_items_in_compositions_on_composition_id"
    t.index ["item_id"], name: "index_items_in_compositions_on_item_id"
    t.index ["product_id"], name: "index_items_in_compositions_on_product_id"
  end

  create_table "items_subcategories", id: false, force: :cascade do |t|
    t.integer "item_id"
    t.integer "subcategory_id"
    t.index ["item_id", "subcategory_id"], name: "index_items_subcategories_on_item_id_and_subcategory_id"
  end

  create_table "letsencrypt_plugin_challenges", id: :serial, force: :cascade do |t|
    t.text "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "letsencrypt_plugin_settings", id: :serial, force: :cascade do |t|
    t.text "private_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "phone"
    t.string "address"
    t.float "total"
    t.text "desc"
    t.datetime "order_date"
    t.string "pay_method"
    t.string "city"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "partners", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.bigint "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "positions", id: :serial, force: :cascade do |t|
    t.integer "cart_id"
    t.integer "item_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "composition_id"
    t.integer "order_id"
    t.index ["cart_id"], name: "index_positions_on_cart_id"
    t.index ["composition_id"], name: "index_positions_on_composition_id"
    t.index ["item_id"], name: "index_positions_on_item_id"
    t.index ["order_id"], name: "index_positions_on_order_id"
  end

  create_table "prices", id: :serial, force: :cascade do |t|
    t.string "price_sheet_file_name"
    t.string "price_sheet_content_type"
    t.bigint "price_sheet_file_size"
    t.datetime "price_sheet_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.integer "item_id"
    t.integer "size_id"
    t.integer "quantity"
    t.float "price"
    t.integer "in_box"
    t.integer "min_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "barcode"
    t.string "code"
    t.string "name"
    t.string "img_file_name"
    t.string "img_content_type"
    t.bigint "img_file_size"
    t.datetime "img_updated_at"
    t.float "price_with_helium", default: 0.0
    t.string "complex_name"
    t.index ["item_id"], name: "index_products_on_item_id"
    t.index ["size_id"], name: "index_products_on_size_id"
  end

  create_table "promotions", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "desc"
    t.string "img_file_name"
    t.string "img_content_type"
    t.bigint "img_file_size"
    t.datetime "img_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receivers", id: :serial, force: :cascade do |t|
    t.text "title"
    t.string "personable_type"
    t.integer "personable_id"
    t.string "slug"
    t.index ["personable_type", "personable_id"], name: "index_receivers_on_personable_type_and_personable_id"
    t.index ["slug"], name: "index_receivers_on_slug"
  end

  create_table "sizes", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vendor_id"
    t.float "in_inch"
    t.float "in_cm"
    t.integer "belbal"
    t.integer "value"
    t.index ["vendor_id"], name: "index_sizes_on_vendor_id"
  end

  create_table "subcategories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "subpositions", id: :serial, force: :cascade do |t|
    t.integer "position_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id"
    t.index ["position_id"], name: "index_subpositions_on_position_id"
    t.index ["product_id"], name: "index_subpositions_on_product_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_tags_on_slug"
    t.index ["taggable_type", "taggable_id"], name: "index_tags_on_taggable_type_and_taggable_id"
  end

  create_table "textures", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tones", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "eng_name"
    t.integer "color_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vendor_id"
    t.string "code"
    t.string "img_file_name"
    t.string "img_content_type"
    t.bigint "img_file_size"
    t.datetime "img_updated_at"
    t.index ["color_id"], name: "index_tones_on_color_id"
    t.index ["vendor_id"], name: "index_tones_on_vendor_id"
  end

  create_table "types", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "eng_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "crypted_password"
    t.string "salt"
    t.string "phone", null: false
    t.string "first_name"
    t.string "last_name"
    t.text "address"
    t.float "discount", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.boolean "admin", default: false
    t.string "source"
    t.integer "card"
    t.index ["phone"], name: "index_users_on_phone", unique: true
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
  end

  create_table "vendors", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "country"
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.bigint "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "abbr"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "carts", "users"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "colors"
  add_foreign_key "items", "foil_forms"
  add_foreign_key "items", "textures"
  add_foreign_key "items", "tones"
  add_foreign_key "items", "types"
  add_foreign_key "items", "vendors"
  add_foreign_key "items_in_compositions", "compositions"
  add_foreign_key "items_in_compositions", "items"
  add_foreign_key "items_in_compositions", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "positions", "carts"
  add_foreign_key "positions", "items"
  add_foreign_key "positions", "orders"
  add_foreign_key "products", "items"
  add_foreign_key "products", "sizes"
  add_foreign_key "subpositions", "positions"
  add_foreign_key "subpositions", "products"
  add_foreign_key "tones", "colors"
  add_foreign_key "tones", "vendors"
end
