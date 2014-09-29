# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140926134202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "album_images", force: true do |t|
    t.string   "title"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "album_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "albums", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "article_images", force: true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "article_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "articles", force: true do |t|
    t.string   "title"
    t.date     "date"
    t.text     "text"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.text     "short_text"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "brands", force: true do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "partner_id"
  end

  create_table "carts", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cases", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.text     "short_description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "slug"
    t.string   "seo_url"
    t.string   "seo_title"
    t.text     "seo_description"
  end

  add_index "cases", ["slug"], name: "index_cases_on_slug", unique: true, using: :btree

  create_table "cases_products", force: true do |t|
    t.integer "case_id"
    t.integer "product_id"
  end

  create_table "cities", force: true do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "consultations", force: true do |t|
    t.text     "question"
    t.text     "answer"
    t.integer  "brand_id"
    t.integer  "case_id"
    t.boolean  "check",      default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "consultations_products", force: true do |t|
    t.integer "consultation_id"
    t.integer "product_id"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "events", force: true do |t|
    t.string   "title"
    t.date     "date"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "city_id"
  end

  create_table "events_users", force: true do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "line_items", force: true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "quantity",   default: 1
    t.integer  "order_id"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "partners", force: true do |t|
    t.string   "title"
    t.string   "address"
    t.integer  "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "website"
    t.string   "phone"
  end

  create_table "procedure_categories", force: true do |t|
    t.string   "title"
    t.integer  "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
  end

  add_index "procedure_categories", ["slug"], name: "index_procedure_categories_on_slug", unique: true, using: :btree

  create_table "procedure_procedure_categories", force: true do |t|
    t.integer  "procedure_id"
    t.integer  "procedure_category_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "procedures", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.text     "short_text"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "procedures_products", force: true do |t|
    t.integer "procedure_id"
    t.integer "product_id"
  end

  create_table "product_categories", force: true do |t|
    t.string   "title"
    t.integer  "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_images", force: true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "product_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "product_taxons", force: true do |t|
    t.integer  "product_id"
    t.integer  "taxon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: true do |t|
    t.string   "title"
    t.string   "packing"
    t.text     "text"
    t.text     "ingredients"
    t.integer  "brand_id"
    t.boolean  "visible_professional",                         default: false
    t.boolean  "visible_dealer1",                              default: false
    t.boolean  "visible_dealer2",                              default: false
    t.boolean  "visible_dealer3",                              default: false
    t.decimal  "price_professional",   precision: 8, scale: 2
    t.decimal  "price_dealer1",        precision: 8, scale: 2
    t.decimal  "price_dealer2",        precision: 8, scale: 2
    t.decimal  "price_dealer3",        precision: 8, scale: 2
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.text     "short_description"
    t.integer  "product_category_id"
    t.boolean  "latest"
    t.string   "slug"
    t.string   "seo_title"
    t.text     "seo_description"
    t.text     "seo_text"
    t.integer  "taxon_id"
    t.integer  "position",                                     default: 0
    t.string   "sku"
    t.integer  "price",                                        default: 0
    t.integer  "new_price"
    t.string   "applying"
    t.boolean  "in_stock",                                     default: true
    t.integer  "bought",                                       default: 0
    t.integer  "product_type",                                 default: 0
    t.integer  "promo_id"
    t.integer  "promo_products_price"
  end

  add_index "products", ["slug"], name: "index_products_on_slug", unique: true, using: :btree

  create_table "publications", force: true do |t|
    t.string   "title"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "questions", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regions", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "related_products", id: false, force: true do |t|
    t.integer  "product_id"
    t.integer  "related_product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "same_taxon_products", id: false, force: true do |t|
    t.integer  "product_id"
    t.integer  "same_product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seo_data", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "seo_text"
    t.string   "page"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "shop_carts", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shop_cases", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.text     "short_description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "slug"
    t.string   "seo_url"
    t.string   "seo_title"
    t.text     "seo_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shop_cases_products", id: false, force: true do |t|
    t.integer "product_id"
    t.integer "case_id"
  end

  create_table "shop_line_items", force: true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.integer  "order_id"
    t.integer  "quantity",   default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shop_orders", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "city"
    t.string   "address"
    t.text     "comment"
    t.integer  "status",     default: 0
    t.integer  "pay_type"
  end

  create_table "shop_product_taxons", force: true do |t|
    t.integer  "product_id"
    t.integer  "taxon_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shop_taxonomies", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.string   "seo_title"
    t.text     "seo_description"
    t.text     "seo_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shop_taxons", force: true do |t|
    t.string   "title"
    t.integer  "taxonomy_id"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "slug"
    t.string   "seo_title"
    t.text     "seo_description"
    t.text     "seo_text"
    t.string   "seo_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "taxon_type",      default: 0
  end

  create_table "shop_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shop_users", ["email"], name: "index_shop_users_on_email", unique: true, using: :btree
  add_index "shop_users", ["reset_password_token"], name: "index_shop_users_on_reset_password_token", unique: true, using: :btree

  create_table "stage_images", force: true do |t|
    t.string   "title"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "stage_stage_images", force: true do |t|
    t.integer  "stage_id"
    t.integer  "stage_image_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "stages", force: true do |t|
    t.string   "title"
    t.integer  "procedure_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "position",     default: 0
  end

  create_table "substage_products", force: true do |t|
    t.integer  "substage_id"
    t.integer  "product_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "substages", force: true do |t|
    t.text     "text"
    t.integer  "stage_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "position",   default: 0
  end

  create_table "taxonomies", force: true do |t|
    t.string   "title"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "slug"
    t.string   "seo_title"
    t.text     "seo_description"
    t.text     "seo_text"
  end

  add_index "taxonomies", ["slug"], name: "index_taxonomies_on_slug", unique: true, using: :btree

  create_table "taxons", force: true do |t|
    t.string   "title"
    t.integer  "taxonomy_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "slug"
    t.string   "seo_title"
    t.text     "seo_description"
    t.text     "seo_text"
    t.string   "seo_url"
  end

  add_index "taxons", ["slug"], name: "index_taxons_on_slug", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "role"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "check"
    t.string   "name"
    t.string   "phone"
    t.boolean  "assignment"
    t.string   "company"
    t.string   "address"
    t.string   "work_phone"
    t.string   "fax"
    t.string   "work_email"
    t.string   "from"
    t.text     "comment"
    t.boolean  "education"
    t.integer  "region_id"
    t.string   "own_region"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "videos", force: true do |t|
    t.string   "title"
    t.string   "youtube"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "brand_id"
  end

end
