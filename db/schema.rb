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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 8) do

  create_table "exp_types", :force => true do |t|
    t.string   "description", :limit => 64
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expenses", :force => true do |t|
    t.date     "exp_date"
    t.integer  "exp_type_id"
    t.decimal  "amount",                         :precision => 12, :scale => 2
    t.string   "note",            :limit => 300
    t.integer  "payment_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients_recipes", :force => true do |t|
    t.integer "recipe_id"
    t.integer "ingredient_id"
  end

  create_table "payment_types", :force => true do |t|
    t.string   "description", :limit => 64
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipes", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "songs", :force => true do |t|
    t.string   "title"
    t.string   "artist"
    t.string   "album"
    t.integer  "tracknum"
    t.string   "genre",      :limit => 50
    t.string   "comments"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "steps", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "sequence_number"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
