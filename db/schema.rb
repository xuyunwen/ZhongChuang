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

ActiveRecord::Schema.define(version: 20160118095957) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapter_comments", force: :cascade do |t|
    t.integer  "chapter_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "chapter_comments", ["chapter_id", "user_id"], name: "index_chapter_comments_on_chapter_id_and_user_id"
  add_index "chapter_comments", ["chapter_id"], name: "index_chapter_comments_on_chapter_id"
  add_index "chapter_comments", ["user_id"], name: "index_chapter_comments_on_user_id"

  create_table "chapter_votes", force: :cascade do |t|
    t.integer  "chapter_id"
    t.integer  "user_id"
    t.integer  "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "chapter_votes", ["chapter_id"], name: "index_chapter_votes_on_chapter_id"
  add_index "chapter_votes", ["user_id"], name: "index_chapter_votes_on_user_id"

  create_table "chapters", force: :cascade do |t|
    t.integer  "novel_id"
    t.integer  "number"
    t.integer  "author_id"
    t.integer  "status"
    t.integer  "cite_id"
    t.string   "title"
    t.text     "content"
    t.text     "summary"
    t.text     "subsequent_summary"
    t.text     "foreshadowing"
    t.boolean  "draft",              default: true
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "chapters", ["author_id"], name: "index_chapters_on_author_id"
  add_index "chapters", ["cite_id"], name: "index_chapters_on_cite_id"
  add_index "chapters", ["novel_id", "number", "author_id"], name: "index_chapters_on_novel_id_and_number_and_author_id"
  add_index "chapters", ["novel_id"], name: "index_chapters_on_novel_id"
  add_index "chapters", ["number"], name: "index_chapters_on_number"
  add_index "chapters", ["title"], name: "index_chapters_on_title"

  create_table "novel_comments", force: :cascade do |t|
    t.integer  "novel_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "novel_comments", ["novel_id", "user_id"], name: "index_novel_comments_on_novel_id_and_user_id"
  add_index "novel_comments", ["novel_id"], name: "index_novel_comments_on_novel_id"
  add_index "novel_comments", ["user_id"], name: "index_novel_comments_on_user_id"

  create_table "novels", force: :cascade do |t|
    t.string   "name"
    t.binary   "cover"
    t.text     "description"
    t.integer  "category_id"
    t.integer  "status",      default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "novels", ["category_id"], name: "index_novels_on_category_id"
  add_index "novels", ["name"], name: "index_novels_on_name"

  create_table "permissions", force: :cascade do |t|
    t.string   "describe"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.integer  "novel_id"
    t.integer  "author_id"
    t.string   "name"
    t.text     "profile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "roles", ["author_id"], name: "index_roles_on_author_id"
  add_index "roles", ["novel_id"], name: "index_roles_on_novel_id"

  create_table "user_group_own_permissions", force: :cascade do |t|
    t.integer  "user_group_id"
    t.integer  "user_level"
    t.integer  "permission_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "user_group_own_permissions", ["permission_id"], name: "index_user_group_own_permissions_on_permission_id"
  add_index "user_group_own_permissions", ["user_group_id", "user_level", "permission_id"], name: "index_ugop_on_user_group_and_user_level_and_permission"
  add_index "user_group_own_permissions", ["user_group_id"], name: "index_user_group_own_permissions_on_user_group_id"

  create_table "user_groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_groups", ["name"], name: "index_user_groups_on_name", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "user_name"
    t.string   "nick_name"
    t.binary   "header"
    t.integer  "user_group_id",   default: 0
    t.integer  "level",           default: 1
    t.string   "password_digest"
    t.string   "remember_digest"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "users", ["user_group_id"], name: "index_users_on_user_group_id"
  add_index "users", ["user_name"], name: "index_users_on_user_name", unique: true

end
