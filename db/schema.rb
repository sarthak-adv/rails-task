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

ActiveRecord::Schema[8.1].define(version: 2026_01_12_060314) do
  create_table "blogs", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.integer "org_id", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["org_id"], name: "index_blogs_on_org_id"
  end

  create_table "org_rules", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "enabled", default: true, null: false
    t.integer "org_id", null: false
    t.integer "rule_id", null: false
    t.datetime "updated_at", null: false
    t.json "value"
    t.index ["org_id", "rule_id"], name: "index_org_rules_on_org_id_and_rule_id", unique: true
    t.index ["org_id"], name: "index_org_rules_on_org_id"
    t.index ["rule_id"], name: "index_org_rules_on_rule_id"
  end

  create_table "orgs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "status", default: "active"
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_orgs_on_name", unique: true
  end

  create_table "rules", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "key", null: false
    t.string "rule_type", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_rules_on_key", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.integer "org_id", null: false
    t.string "password_digest"
    t.integer "role", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["org_id"], name: "index_users_on_org_id"
  end

  add_foreign_key "blogs", "orgs"
  add_foreign_key "org_rules", "orgs"
  add_foreign_key "org_rules", "rules"
  add_foreign_key "users", "orgs"
end
