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

ActiveRecord::Schema.define(version: 2018_12_01_142621) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "ctoken"
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ctoken"], name: "index_clients_on_ctoken", unique: true
    t.index ["employee_id"], name: "index_clients_on_employee_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "identity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "employees_count", default: 0
    t.index ["identity"], name: "index_companies_on_identity", unique: true
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "identifier"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "clients_count", default: 0
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["identifier"], name: "index_employees_on_identifier", unique: true
  end

  add_foreign_key "clients", "employees"
  add_foreign_key "employees", "companies"
end
