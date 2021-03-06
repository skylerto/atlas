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

ActiveRecord::Schema.define(version: 20180103191650) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deployments", force: :cascade do |t|
    t.bigint "environment_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status", default: false
    t.index ["environment_id"], name: "index_deployments_on_environment_id"
  end

  create_table "deployments_versions", id: false, force: :cascade do |t|
    t.integer "version_id"
    t.integer "deployment_id"
    t.index ["version_id", "deployment_id"], name: "index_deployments_versions_on_version_id_and_deployment_id"
  end

  create_table "environments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "environments_versions", id: false, force: :cascade do |t|
    t.integer "version_id"
    t.integer "environment_id"
    t.index ["version_id", "environment_id"], name: "index_environments_versions_on_version_id_and_environment_id"
  end

  create_table "jenkins", force: :cascade do |t|
    t.string "server_ip"
    t.string "username"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "versions", force: :cascade do |t|
    t.bigint "service_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_versions_on_service_id"
  end

  add_foreign_key "deployments", "environments"
  add_foreign_key "versions", "services"
end
