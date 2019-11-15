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

ActiveRecord::Schema.define(version: 2019_11_15_024452) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apht_orders", force: :cascade do |t|
    t.string "proof_of_ownership"
    t.string "collateral_value"
    t.string "owner"
    t.string "name_representative"
    t.string "certificate_number"
    t.datetime "publication_date"
    t.string "province"
    t.string "city"
    t.string "district"
    t.string "village"
    t.string "street"
    t.string "land_area"
    t.string "letter_of_measurement"
    t.datetime "tanggal_gs_su"
    t.string "no_land_identity"
    t.string "letter_of_pbbtax"
    t.string "nop"
    t.string "binding_value"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_apht_orders_on_order_id"
  end

  create_table "collaterals", force: :cascade do |t|
    t.integer "collateral_type"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price", default: "0.0"
    t.index ["order_id"], name: "index_collaterals_on_order_id"
  end

  create_table "fidusia_orders", force: :cascade do |t|
    t.string "proof_of_ownership"
    t.string "owner"
    t.string "name_representative"
    t.string "no_evidence"
    t.datetime "publication_date"
    t.string "machine_number"
    t.string "chassis_number"
    t.string "brand"
    t.string "classification"
    t.string "seri"
    t.string "collateral_value"
    t.string "binding_value"
    t.string "imageable_type"
    t.bigint "imageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_id"
    t.string "color"
    t.index ["imageable_type", "imageable_id"], name: "index_fidusia_orders_on_imageable_type_and_imageable_id"
  end

  create_table "indonesia_cities", force: :cascade do |t|
    t.string "city_name"
    t.integer "indonesia_province_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "indonesia_districts", force: :cascade do |t|
    t.string "district_name"
    t.integer "indonesia_city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "indonesia_provinces", force: :cascade do |t|
    t.string "province_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "indonesia_villages", force: :cascade do |t|
    t.string "village_name"
    t.integer "indonesia_district_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notary_services", force: :cascade do |t|
    t.integer "service_type"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_notary_services_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "status"
    t.integer "grand_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_type"
    t.integer "notary_id"
    t.integer "user_id"
    t.datetime "expired_date"
    t.datetime "valid_expired_datetime"
    t.index ["notary_id"], name: "index_orders_on_notary_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
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

  create_table "skmht_orders", force: :cascade do |t|
    t.string "proof_of_ownership"
    t.string "collateral_value"
    t.string "owner"
    t.string "name_representative"
    t.string "certificate_number"
    t.datetime "publication_date"
    t.string "province"
    t.string "city"
    t.string "district"
    t.string "village"
    t.string "street"
    t.string "land_area"
    t.string "letter_of_measurement"
    t.datetime "tanggal_gs_su"
    t.string "no_land_identity"
    t.string "letter_of_pbbtax"
    t.string "nop"
    t.string "binding_value"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_skmht_orders_on_order_id"
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
    t.string "gender"
    t.string "dob"
    t.string "identity_image"
    t.string "selfie_image"
    t.string "privy_token"
    t.integer "user_tipe"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "province"
    t.string "city"
    t.string "district"
    t.string "village"
    t.float "lng"
    t.float "lat"
    t.string "address"
    t.string "office_address"
    t.text "komparisi"
    t.string "occupation"
    t.string "name_organization"
    t.string "no_sk_notaris"
    t.string "tgl_sk_notaris"
    t.string "no_akta"
    t.string "tgl_akta"
    t.string "fax"
    t.string "bank_account_notaris"
    t.string "bank_name"
    t.integer "indonesia_city_id"
    t.string "name_companion"
    t.string "idcard_number_companion"
    t.string "gender_companion"
    t.string "address_companion"
    t.string "status_companion"
    t.text "komparisi_companion"
    t.float "lat_companion"
    t.float "lng_companion"
    t.string "name_ppat"
    t.string "no_sk_notaris_ppat"
    t.string "tgl_sk_ppat"
    t.text "komparisi_ppat"
    t.string "no_akta_ppat"
    t.string "tgl_akta_ppat"
    t.string "address_ppat"
    t.string "fax_ppat"
    t.string "no_rekening_ppat"
    t.string "bank_name_ppat"
    t.float "lat_ppat"
    t.float "lng_ppat"
    t.string "mother_bpn"
    t.string "address_in_idcard_bpn"
    t.string "address_bpn"
    t.integer "indonesia_village_id"
    t.string "pob"
    t.integer "valid_count_search_notaris", default: 0
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
