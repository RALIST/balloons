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

ActiveRecord::Schema.define(version: 20190328095423) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calls", force: :cascade do |t|
    t.string   "username"
    t.string   "userphone"
    t.text     "messangers",              array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "url"
    t.string   "city"
  end

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.float    "total"
    t.integer  "used_code_discount", default: 0
    t.index ["user_id"], name: "index_carts_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.text     "desc"
    t.string   "img_file_name"
    t.string   "img_content_type"
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "colors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "compositions", force: :cascade do |t|
    t.string   "title"
    t.string   "img_file_name"
    t.string   "img_content_type"
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "deleted",          default: false
    t.float    "price",            default: 0.0
    t.integer  "views",            default: 0
  end

  create_table "compositions_receivers", id: false, force: :cascade do |t|
    t.integer "composition_id"
    t.integer "receiver_id"
    t.index ["composition_id", "receiver_id"], name: "index_compositions_receivers_on_composition_id_and_receiver_id", using: :btree
  end

  create_table "compositions_tags", id: false, force: :cascade do |t|
    t.integer "composition_id"
    t.integer "tag_id"
    t.index ["composition_id", "tag_id"], name: "index_compositions_tags_on_composition_id_and_tag_id", using: :btree
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "name"
    t.text     "body"
    t.string   "img_file_name"
    t.string   "img_content_type"
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "phone"
    t.string   "social_url"
    t.string   "promocode"
  end

  create_table "foil_forms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.string   "img_file_name"
    t.string   "img_content_type"
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "style"
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id", using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "item_type"
    t.boolean  "deleted",      default: false
    t.integer  "vendor_id"
    t.integer  "tone_id"
    t.integer  "texture_id"
    t.integer  "category_id"
    t.integer  "type_id"
    t.integer  "color_id"
    t.integer  "foil_form_id"
    t.index ["category_id"], name: "index_items_on_category_id", using: :btree
    t.index ["color_id"], name: "index_items_on_color_id", using: :btree
    t.index ["foil_form_id"], name: "index_items_on_foil_form_id", using: :btree
    t.index ["texture_id"], name: "index_items_on_texture_id", using: :btree
    t.index ["tone_id"], name: "index_items_on_tone_id", using: :btree
    t.index ["type_id"], name: "index_items_on_type_id", using: :btree
    t.index ["vendor_id"], name: "index_items_on_vendor_id", using: :btree
  end

  create_table "items_in_compositions", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "composition_id"
    t.integer  "items_count"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "product_id"
    t.index ["composition_id"], name: "index_items_in_compositions_on_composition_id", using: :btree
    t.index ["item_id"], name: "index_items_in_compositions_on_item_id", using: :btree
    t.index ["product_id"], name: "index_items_in_compositions_on_product_id", using: :btree
  end

  create_table "items_subcategories", id: false, force: :cascade do |t|
    t.integer "item_id"
    t.integer "subcategory_id"
    t.index ["item_id", "subcategory_id"], name: "index_items_subcategories_on_item_id_and_subcategory_id", using: :btree
  end

  create_table "letsencrypt_plugin_challenges", force: :cascade do |t|
    t.text     "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "letsencrypt_plugin_settings", force: :cascade do |t|
    t.text     "private_key"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.string   "phone"
    t.string   "address"
    t.float    "total"
    t.text     "desc"
    t.datetime "order_date"
    t.string   "pay_method"
    t.string   "city"
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "partners", force: :cascade do |t|
    t.string   "name"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "positions", force: :cascade do |t|
    t.integer  "cart_id"
    t.integer  "item_id"
    t.integer  "quantity"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "composition_id"
    t.integer  "order_id"
    t.index ["cart_id"], name: "index_positions_on_cart_id", using: :btree
    t.index ["composition_id"], name: "index_positions_on_composition_id", using: :btree
    t.index ["item_id"], name: "index_positions_on_item_id", using: :btree
    t.index ["order_id"], name: "index_positions_on_order_id", using: :btree
  end

  create_table "prices", force: :cascade do |t|
    t.string   "price_sheet_file_name"
    t.string   "price_sheet_content_type"
    t.integer  "price_sheet_file_size"
    t.datetime "price_sheet_updated_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "size_id"
    t.integer  "quantity"
    t.float    "price"
    t.integer  "in_box"
    t.integer  "min_order"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.bigint   "barcode"
    t.string   "code"
    t.string   "name"
    t.string   "img_file_name"
    t.string   "img_content_type"
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
    t.float    "price_with_helium", default: 0.0
    t.string   "complex_name"
    t.index ["item_id"], name: "index_products_on_item_id", using: :btree
    t.index ["size_id"], name: "index_products_on_size_id", using: :btree
  end

  create_table "promotions", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "desc"
    t.string   "img_file_name"
    t.string   "img_content_type"
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "receivers", force: :cascade do |t|
    t.text    "title"
    t.string  "personable_type"
    t.integer "personable_id"
    t.string  "slug"
    t.index ["personable_type", "personable_id"], name: "index_receivers_on_personable_type_and_personable_id", using: :btree
    t.index ["slug"], name: "index_receivers_on_slug", using: :btree
  end

  create_table "sizes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "vendor_id"
    t.float    "in_inch"
    t.float    "in_cm"
    t.integer  "belbal"
    t.integer  "value"
    t.index ["vendor_id"], name: "index_sizes_on_vendor_id", using: :btree
  end

  create_table "subcategories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "subpositions", force: :cascade do |t|
    t.integer  "position_id"
    t.integer  "quantity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "product_id"
    t.index ["position_id"], name: "index_subpositions_on_position_id", using: :btree
    t.index ["product_id"], name: "index_subpositions_on_product_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "slug"
    t.index ["slug"], name: "index_tags_on_slug", using: :btree
    t.index ["taggable_type", "taggable_id"], name: "index_tags_on_taggable_type_and_taggable_id", using: :btree
  end

  create_table "textures", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tones", force: :cascade do |t|
    t.string   "name"
    t.string   "eng_name"
    t.integer  "color_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "vendor_id"
    t.string   "code"
    t.string   "img_file_name"
    t.string   "img_content_type"
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
    t.index ["color_id"], name: "index_tones_on_color_id", using: :btree
    t.index ["vendor_id"], name: "index_tones_on_vendor_id", using: :btree
  end

  create_table "types", force: :cascade do |t|
    t.string   "name"
    t.string   "eng_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "phone",                                        null: false
    t.string   "first_name"
    t.string   "last_name"
    t.text     "address"
    t.float    "discount",                     default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.boolean  "admin",                        default: false
    t.string   "source"
    t.integer  "card"
    t.index ["phone"], name: "index_users_on_phone", unique: true, using: :btree
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  end

  create_table "vendors", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "country"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "abbr"
  end

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
