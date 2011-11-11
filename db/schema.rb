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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111111145133) do

  create_table "calculations", :force => true do |t|
    t.string   "profile_uid"
    t.string   "profile_item_uid"
    t.string   "calculation_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "calculations", ["calculation_type"], :name => "index_calculations_on_calculation_type"
  add_index "calculations", ["profile_item_uid"], :name => "index_calculations_on_profile_item_uid"

  create_table "checkins", :force => true do |t|
    t.string   "lat"
    t.string   "lon"
    t.datetime "timestamp"
    t.string   "foursquare_id"
    t.string   "timezone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "venue_name"
    t.integer  "user_id"
    t.string   "icon"
    t.integer  "leg_id"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "legs", :force => true do |t|
    t.string   "distance"
    t.string   "co2"
    t.string   "name"
    t.integer  "end_checkin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.datetime "timestamp"
    t.string   "timezone"
    t.integer  "start_checkin_id"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "terms", :force => true do |t|
    t.integer  "calculation_id"
    t.string   "label"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "unit"
    t.string   "per_unit"
    t.string   "value_type"
  end

  add_index "terms", ["calculation_id", "label"], :name => "calc_id_label_index"
  add_index "terms", ["label", "value", "calculation_id"], :name => "label_name_calc_id_index"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "token"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "foursquare_id"
    t.datetime "last_email_sent"
  end

end
