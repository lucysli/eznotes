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

ActiveRecord::Schema.define(version: 20130920180417) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accomodations", force: true do |t|
    t.string   "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "note_taking"
  end

  add_index "accomodations", ["student_id"], name: "index_accomodations_on_student_id", unique: true, using: :btree

  create_table "courses", force: true do |t|
    t.string   "course_title"
    t.string   "subject_code"
    t.string   "course_num"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "term"
    t.string   "section"
    t.integer  "user_id"
    t.integer  "crn"
  end

  add_index "courses", ["crn", "term"], name: "index_courses_on_crn_and_term", unique: true, using: :btree
  add_index "courses", ["subject_code", "course_num", "term", "section"], name: "course_lookup_index", unique: true, using: :btree

  create_table "notes", force: true do |t|
    t.string   "lecture_title"
    t.date     "lecture_date"
    t.text     "comments"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "course_id"
  end

  add_index "notes", ["course_id", "created_at"], name: "index_notes_on_course_id_and_created_at", using: :btree
  add_index "notes", ["user_id", "created_at"], name: "index_notes_on_user_id_and_created_at", using: :btree

  create_table "registrations", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "registrations", ["course_id"], name: "index_registrations_on_course_id", using: :btree
  add_index "registrations", ["user_id", "course_id"], name: "index_registrations_on_user_id_and_course_id", unique: true, using: :btree
  add_index "registrations", ["user_id"], name: "index_registrations_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "student_id"
    t.string   "remember_token"
    t.boolean  "admin",                  default: false
    t.boolean  "note_taker",             default: false
    t.string   "password_digest"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "approved",               default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree
  add_index "users", ["student_id"], name: "index_users_on_student_id", unique: true, using: :btree

end
