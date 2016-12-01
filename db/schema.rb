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

ActiveRecord::Schema.define(version: 20161129173756) do

  create_table "clients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "address"
    t.string   "site"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "service_type_id"
    t.integer  "client_id"
    t.boolean  "active"
    t.boolean  "suspended"
    t.text     "info",            limit: 65535
    t.datetime "suspended_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["client_id"], name: "index_services_on_client_id", using: :btree
    t.index ["service_type_id"], name: "index_services_on_service_type_id", using: :btree
  end

  create_table "settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "key",        null: false
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "created_by_id"
    t.integer  "client_id"
    t.datetime "when",                                        null: false
    t.integer  "duration",                                    null: false
    t.boolean  "single_event",                                null: false
    t.string   "activity",                                    null: false
    t.text     "comment",       limit: 65535
    t.boolean  "done",                        default: false
    t.datetime "done_at"
    t.string   "color",                                       null: false
    t.string   "token",                                       null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.index ["client_id"], name: "index_tasks_on_client_id", using: :btree
    t.index ["created_by_id"], name: "index_tasks_on_created_by_id", using: :btree
    t.index ["user_id"], name: "index_tasks_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "role"
    t.string   "photo"
    t.string   "background"
    t.datetime "confirmed_at"
    t.string   "confirmation_token"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_foreign_key "services", "clients"
  add_foreign_key "services", "service_types"
  add_foreign_key "tasks", "clients"
  add_foreign_key "tasks", "users"
  add_foreign_key "tasks", "users", column: "created_by_id"
end
