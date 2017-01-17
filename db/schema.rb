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

ActiveRecord::Schema.define(version: 20170116191718) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "compositions", force: :cascade do |t|
    t.string   "title"
    t.string   "price"
    t.string   "img_file_name"
    t.string   "img_content_type"
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.text     "desc"
    t.float    "price"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "img_file_name"
    t.string   "img_content_type"
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
    t.integer  "price_with_helium"
    t.string   "item_type"
    t.string   "made_by"
    t.string   "barcode"
    t.string   "collection"
    t.integer  "min_order"
    t.string   "quantity_type"
  end

  create_table "items_in_compositions", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "composition_id"
    t.integer  "items_count"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["composition_id"], name: "index_items_in_compositions_on_composition_id", using: :btree
    t.index ["item_id"], name: "index_items_in_compositions_on_item_id", using: :btree
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
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
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

  create_table "subpositions", force: :cascade do |t|
    t.integer  "position_id"
    t.integer  "item_id"
    t.integer  "quantity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["item_id"], name: "index_subpositions_on_item_id", using: :btree
    t.index ["position_id"], name: "index_subpositions_on_position_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["taggable_type", "taggable_id"], name: "index_tags_on_taggable_type_and_taggable_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "phone",                                      null: false
    t.string   "first_name"
    t.string   "last_name"
    t.text     "address"
    t.float    "discount",                     default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.index ["phone"], name: "index_users_on_phone", unique: true, using: :btree
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  end

  add_foreign_key "carts", "users"
  add_foreign_key "items_in_compositions", "compositions"
  add_foreign_key "items_in_compositions", "items"
  add_foreign_key "orders", "users"
  add_foreign_key "positions", "carts"
  add_foreign_key "positions", "items"
  add_foreign_key "positions", "orders"
  add_foreign_key "subpositions", "items"
  add_foreign_key "subpositions", "positions"
end
