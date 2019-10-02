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

ActiveRecord::Schema.define(version: 2019_10_02_000058) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fidusia_orders", force: :cascade do |t|
    t.string "proof_of_ownership"
    t.string "owner"
    t.string "on_behalf_of"
    t.string "number_of_evidence"
    t.datetime "publication_date"
    t.string "machine_number"
    t.string "chassis_number"
    t.string "brand"
    t.string "tipe"
    t.string "seri"
    t.string "collateral_value"
    t.string "binding_value"
    t.string "imageable_type"
    t.bigint "imageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_id"
    t.index ["imageable_type", "imageable_id"], name: "index_fidusia_orders_on_imageable_type_and_imageable_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "status"
    t.integer "grand_total"
    t.bigint "orderable_id"
    t.string "orderable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["orderable_type", "orderable_id"], name: "index_orders_on_orderable_type_and_orderable_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "resource_type"
    t.bigint "resource_id"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approved", default: false
    t.integer "organizational_status", default: 0
    t.string "phone"
    t.string "identity_number"
    t.integer "gender"
    t.date "dob"
    t.string "identity_image"
    t.string "selfie_image"
    t.string "privy_token"
  end

  create_table "users_roles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "users_roles", "roles"
  add_foreign_key "users_roles", "users"
end
