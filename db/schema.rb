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

ActiveRecord::Schema[7.0].define(version: 2022_10_09_194110) do
  create_table "deadlines", force: :cascade do |t|
    t.integer "initial_interval"
    t.integer "final_interval"
    t.integer "duration"
    t.integer "modality_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["modality_id"], name: "index_deadlines_on_modality_id"
  end

  create_table "distance_prices", force: :cascade do |t|
    t.integer "initial_distance"
    t.integer "final_distance"
    t.integer "distance_rate"
    t.integer "modality_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["modality_id"], name: "index_distance_prices_on_modality_id"
  end

  create_table "modalities", force: :cascade do |t|
    t.string "name"
    t.integer "minimum_distance"
    t.integer "maximum_distance"
    t.integer "minimum_weight"
    t.integer "maximum_weight"
    t.integer "flat_rate"
    t.integer "modality_status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "open_work_orders", force: :cascade do |t|
    t.integer "modality_id", null: false
    t.integer "deadline_id", null: false
    t.integer "distance_price_id", null: false
    t.integer "weight_price_id", null: false
    t.integer "work_order_id", null: false
    t.integer "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deadline_id"], name: "index_open_work_orders_on_deadline_id"
    t.index ["distance_price_id"], name: "index_open_work_orders_on_distance_price_id"
    t.index ["modality_id"], name: "index_open_work_orders_on_modality_id"
    t.index ["weight_price_id"], name: "index_open_work_orders_on_weight_price_id"
    t.index ["work_order_id"], name: "index_open_work_orders_on_work_order_id"
  end

  create_table "user_adms", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_user_adms_on_email", unique: true
    t.index ["reset_password_token"], name: "index_user_adms_on_reset_password_token", unique: true
  end

  create_table "user_regulars", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_user_regulars_on_email", unique: true
    t.index ["reset_password_token"], name: "index_user_regulars_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.integer "registration_plate"
    t.string "brand"
    t.string "car_model"
    t.integer "model_year"
    t.integer "weight_capacity"
    t.integer "car_status", default: 0
    t.integer "modality_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["modality_id"], name: "index_vehicles_on_modality_id"
  end

  create_table "weight_prices", force: :cascade do |t|
    t.integer "initial_weight"
    t.integer "final_weight"
    t.integer "weight_rate"
    t.integer "modality_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["modality_id"], name: "index_weight_prices_on_modality_id"
  end

  create_table "work_orders", force: :cascade do |t|
    t.string "pickup_address"
    t.string "pickup_city"
    t.string "pickup_state"
    t.string "product_code"
    t.integer "height"
    t.integer "width"
    t.integer "depth"
    t.integer "weight"
    t.string "delivery_address"
    t.string "customer_name"
    t.string "delivery_city"
    t.string "delivery_state"
    t.integer "distance"
    t.integer "work_order_status", default: 0
    t.string "delivery_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "deadlines", "modalities"
  add_foreign_key "distance_prices", "modalities"
  add_foreign_key "open_work_orders", "deadlines"
  add_foreign_key "open_work_orders", "distance_prices"
  add_foreign_key "open_work_orders", "modalities"
  add_foreign_key "open_work_orders", "weight_prices"
  add_foreign_key "open_work_orders", "work_orders"
  add_foreign_key "vehicles", "modalities"
  add_foreign_key "weight_prices", "modalities"
end
