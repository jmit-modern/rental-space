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

ActiveRecord::Schema.define(version: 2022_01_20_130324) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", comment: "Category name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false, comment: "Country Name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "event_images", force: :cascade do |t|
    t.bigint "event_id"
    t.integer "image_type", comment: "Image type (0: image, 1: movie)"
    t.string "url", comment: "Image url"
    t.string "file_name", comment: "File name"
    t.string "caption", comment: "Image caption"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_event_images_on_event_id"
  end

  create_table "event_reservations", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "user_id"
    t.string "qr_code", comment: "QR code image url"
    t.string "stripe_id", comment: "Stripe payment id"
    t.string "stripe_customer", comment: "Stripe customer id"
    t.string "stripe_payment_method", comment: "Stripe card id"
    t.integer "sub_total", comment: "Paid amount"
    t.integer "admin_fee", comment: "Admin fee"
    t.integer "owner_tax", comment: "Owner Tax"
    t.integer "total", comment: "Paid amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status"
    t.index ["event_id"], name: "index_event_reservations_on_event_id"
    t.index ["user_id"], name: "index_event_reservations_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name", comment: "Event name"
    t.text "description", comment: "Description"
    t.integer "price", comment: "Price"
    t.integer "price_type", comment: "Price type (0: hourly, 1: fixed)"
    t.bigint "space_id", comment: "Spaces.id"
    t.datetime "starting_at", comment: "Starting date time"
    t.datetime "ending_at", comment: "Starting date time"
    t.integer "cancellation_deadline", null: false, comment: "Cancellation deadline"
    t.bigint "language_id", comment: "Language"
    t.integer "status", default: 1, comment: "Status (0: active, 1: deleted)"
    t.text "contact", comment: "Contact info"
    t.string "site_url", comment: "Site url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "category_id"
    t.bigint "user_id"
    t.index ["category_id"], name: "index_events_on_category_id"
    t.index ["language_id"], name: "index_events_on_language_id"
    t.index ["space_id"], name: "index_events_on_space_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "expert_reservations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "expert_id"
    t.string "location", comment: "Reservation location"
    t.integer "people", comment: "Number of People"
    t.integer "children", comment: "Number of Children"
    t.bigint "category_id"
    t.text "description", comment: "Usage description"
    t.integer "sub_total", comment: "Paid amount"
    t.integer "admin_fee", comment: "Admin fee"
    t.integer "owner_tax", comment: "Owner Tax"
    t.integer "total", comment: "Total paid"
    t.datetime "reserve_from", comment: "Reserve from"
    t.datetime "reserve_to", comment: "Reserve to"
    t.integer "approved", comment: "Approve status"
    t.integer "status", comment: "Reservation status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_expert_reservations_on_category_id"
    t.index ["expert_id"], name: "index_expert_reservations_on_expert_id"
    t.index ["user_id"], name: "index_expert_reservations_on_user_id"
  end

  create_table "expert_skills", force: :cascade do |t|
    t.bigint "expert_id", comment: "Experts.id"
    t.bigint "skill_id", comment: "Skills.id"
    t.index ["expert_id"], name: "index_expert_skills_on_expert_id"
    t.index ["skill_id"], name: "index_expert_skills_on_skill_id"
  end

  create_table "experts", force: :cascade do |t|
    t.bigint "user_id", comment: "Users.id"
    t.string "skill_title", comment: "Skill title"
    t.text "description", comment: "Skill Description"
    t.integer "price", comment: "Price"
    t.integer "cancellation_deadline", null: false, comment: "Cancellation deadline"
    t.bigint "language_id", comment: "Languages.id"
    t.string "url", comment: "Url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_experts_on_category_id"
    t.index ["language_id"], name: "index_experts_on_language_id"
    t.index ["user_id"], name: "index_experts_on_user_id"
  end

  create_table "facilities", force: :cascade do |t|
    t.string "name"
    t.bigint "facility_category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["facility_category_id"], name: "index_facilities_on_facility_category_id"
  end

  create_table "facility_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string "name", null: false, comment: "Language"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name", null: false, comment: "Prefecture Name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "space_id"
    t.bigint "space_plan_id"
    t.integer "people", comment: "Number of People"
    t.integer "children", comment: "Number of Children"
    t.bigint "category_id"
    t.text "description", comment: "Usage description"
    t.integer "sub_total", comment: "Paid amount"
    t.integer "admin_fee", comment: "Admin fee"
    t.integer "owner_tax", comment: "Owner Tax"
    t.integer "total", comment: "Total paid"
    t.datetime "reserve_from", comment: "Reserve from"
    t.datetime "reserve_to", comment: "Reserve to"
    t.integer "approved", comment: "Approve status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status"
    t.index ["category_id"], name: "index_reservations_on_category_id"
    t.index ["space_id"], name: "index_reservations_on_space_id"
    t.index ["space_plan_id"], name: "index_reservations_on_space_plan_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name", comment: "Skill name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_skills_on_name", unique: true
  end

  create_table "space_facilities", force: :cascade do |t|
    t.bigint "space_id", null: false
    t.bigint "facility_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["facility_id"], name: "index_space_facilities_on_facility_id"
    t.index ["space_id"], name: "index_space_facilities_on_space_id"
  end

  create_table "space_images", force: :cascade do |t|
    t.bigint "space_id"
    t.integer "image_type", comment: "Image type (0: image, 1: movie)"
    t.string "url", comment: "Image url"
    t.string "file_name", comment: "File name"
    t.string "caption", comment: "Image caption"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["space_id"], name: "index_space_images_on_space_id"
  end

  create_table "space_plans", force: :cascade do |t|
    t.bigint "space_id"
    t.string "name", comment: "Plan name"
    t.integer "minimum_time", comment: "Minimum use time"
    t.integer "price", comment: "Plan price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["space_id"], name: "index_space_plans_on_space_id"
  end

  create_table "spaces", force: :cascade do |t|
    t.bigint "user_id", comment: "Users.id"
    t.string "name", null: false, comment: "Space Name"
    t.text "description", comment: "Description"
    t.integer "space_type", null: false, comment: "Space Type (0: room, 1:House, 2: Warehouse, 3: plaza)"
    t.string "address1", comment: "Space Address 1"
    t.string "address2", comment: "Space Address 2"
    t.string "address3", comment: "Space Address 3"
    t.bigint "prefecture_id", comment: "prefectures.id"
    t.bigint "country_id", comment: "countries.id"
    t.string "zip_code", comment: "Zip code"
    t.string "url", comment: "URL"
    t.string "gps", comment: "GPS"
    t.float "price", comment: "Price"
    t.integer "cancellation_deadline", null: false, comment: "Cancellation deadline"
    t.integer "capacity", comment: "Capacity"
    t.string "language", comment: "Language"
    t.text "facility", comment: "Facility"
    t.text "lodging", comment: "Lodging"
    t.text "loud_volume", comment: "Loud volume"
    t.text "cooking", comment: "Cooking"
    t.text "wifi", comment: "Wifi"
    t.text "parking", comment: "Parking"
    t.integer "status", default: 0, comment: "Status (0: active, 1: deleted)"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "category_id"
    t.float "lat"
    t.float "lng"
    t.index ["category_id"], name: "index_spaces_on_category_id"
    t.index ["country_id"], name: "index_spaces_on_country_id"
    t.index ["prefecture_id"], name: "index_spaces_on_prefecture_id"
    t.index ["user_id"], name: "index_spaces_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", comment: "Username"
    t.string "first_name", null: false, comment: "First Name"
    t.string "last_name", null: false, comment: "Last Name"
    t.string "email", null: false, comment: "Email Address"
    t.string "password_digest", null: false, comment: "Password"
    t.integer "user_type", null: false, comment: "User Type (0:User, 1:Space Owner, 2: Experts, 3:Admin)"
    t.string "card_number", comment: "Card Number"
    t.string "photo", comment: "User photo"
    t.integer "status", default: 0, comment: "User Status (0: active, 1: deactive, 2: deleted)"
    t.datetime "last_login", comment: "Last Login"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
    t.string "phone"
    t.string "address"
    t.string "stripe_customer"
    t.string "confirm_token"
  end

end
