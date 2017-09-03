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

ActiveRecord::Schema.define(version: 20170320031918) do

  create_table "absents", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "kid_id"
    t.date     "absent_date"
  end

  create_table "classrooms", force: :cascade do |t|
    t.string   "class_name"
    t.integer  "capacity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "start_range"
    t.integer  "end_range"
    t.integer  "user_id"
    t.string   "ffrate"
  end

  create_table "kids", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.date     "dob"
    t.string   "gender"
    t.string   "religion"
    t.date     "admission_date"
    t.string   "street_addr"
    t.string   "province"
    t.string   "postal_code"
    t.string   "city"
    t.string   "phone"
    t.string   "student_id"
    t.text     "notes"
    t.string   "gaurdian_one_name"
    t.string   "gaurdian_one_relationship"
    t.string   "gaurdian_one_home_phone"
    t.string   "gaurdian_one_mobile_phone"
    t.string   "gaurdian_one_bus_phone"
    t.string   "gaurdian_one_email"
    t.string   "gaurdian_one_employer"
    t.text     "gaurdian_one_notes"
    t.string   "gaurdian_two_name"
    t.string   "gaurdian_two_relationship"
    t.string   "gaurdian_two_home_phone"
    t.string   "gaurdian_two_mobile_phone"
    t.string   "gaurdian_two_bus_phone"
    t.string   "gaurdian_two_email"
    t.string   "gaurdian_two_employer"
    t.text     "gaurdian_two_notes"
    t.string   "emerg_contact_one_name"
    t.string   "emerg_contact_one_phone"
    t.string   "emerg_contact_one_relationship"
    t.string   "emerg_contact_two_name"
    t.string   "emerg_contact_two_phone"
    t.string   "emerg_contact_two_relationship"
    t.string   "emerg_contact_three_name"
    t.string   "emerg_contact_three_phone"
    t.string   "emerg_contact_three_relationship"
    t.string   "physician_name"
    t.string   "physician_phone"
    t.string   "physician_fax"
    t.string   "physician_addr"
    t.string   "physician_city"
    t.string   "physician_postal_code"
    t.string   "ohip"
    t.string   "physician_notes"
    t.string   "school_name"
    t.string   "school_phone"
    t.date     "discharge_date"
    t.string   "class_name"
    t.integer  "student_number"
    t.integer  "user_id"
    t.boolean  "ba"
    t.boolean  "sunscreen"
    t.boolean  "diaper_cream"
    t.boolean  "hand_sanitizer"
    t.boolean  "face_painting"
    t.boolean  "vidpic_taking"
    t.boolean  "nuts"
    t.boolean  "fish"
    t.boolean  "eggs"
    t.boolean  "milk"
    t.boolean  "latex"
    t.boolean  "medication"
    t.string   "medication_text"
    t.boolean  "insect_sting"
    t.string   "insect_sting_text"
    t.boolean  "other"
    t.string   "other_text"
    t.boolean  "asthmatic"
    t.string   "asthmatic_medication"
    t.date     "asthmatic_medication_expiry"
    t.text     "emergency_action_plan"
    t.date     "epipen_expiry"
    t.string   "epipen_location"
    t.boolean  "epipen_jr_15mg"
    t.boolean  "epipen_30mg"
    t.boolean  "epipen_twinject_15mg"
    t.boolean  "epipen_twinject_30mg"
    t.boolean  "epipen_other_dosage"
    t.string   "epipen_other_dosage_text"
    t.string   "allergy_description_one"
    t.string   "allergy_medication_one"
    t.string   "allergy_symptoms_one"
    t.date     "allergy_expiry_one"
    t.text     "allergy_actions_one"
    t.boolean  "allergy_epipen_one"
    t.string   "allergy_description_two"
    t.string   "allergy_medication_two"
    t.string   "allergy_symptoms_two"
    t.date     "allergy_expiry_two"
    t.text     "allergy_actions_two"
    t.boolean  "allergy_epipen_two"
    t.string   "allergy_description_three"
    t.string   "allergy_medication_three"
    t.string   "allergy_symptoms_three"
    t.date     "allergy_expiry_three"
    t.text     "allergy_actions_three"
    t.boolean  "allergy_epipen_three"
    t.string   "food_description_one"
    t.string   "food_medication_one"
    t.string   "food_symptoms_one"
    t.date     "food_expiry_one"
    t.text     "food_actions_one"
    t.boolean  "food_epipen_one"
    t.string   "food_description_two"
    t.string   "food_medication_two"
    t.string   "food_symptoms_two"
    t.date     "food_expiry_two"
    t.text     "food_actions_two"
    t.boolean  "food_epipen_two"
    t.string   "food_description_three"
    t.string   "food_medication_three"
    t.string   "food_symptoms_three"
    t.date     "food_expiry_three"
    t.text     "food_actions_three"
    t.boolean  "food_epipen_three"
    t.string   "bus_route"
    t.string   "bus_driver"
    t.text     "special_alerts"
    t.string   "emerg_contact_one_work"
    t.string   "emerg_contact_one_cell"
    t.string   "emerg_contact_two_work"
    t.string   "emerg_contact_two_cell"
    t.string   "emerg_contact_three_work"
    t.string   "emerg_contact_three_cell"
    t.boolean  "warning_15_days_issued"
    t.boolean  "warning_20_consecutive_days_issued"
    t.boolean  "join_after_july_1st_issued"
    t.boolean  "warning_25_days_issued"
    t.boolean  "warning_33_days_issued"
    t.boolean  "warning_35_days_issued"
    t.boolean  "review_letter_issued"
    t.string   "food_description_four"
    t.string   "food_medication_four"
    t.string   "food_symptoms_four"
    t.date     "food_expiry_four"
    t.text     "food_actions_four"
    t.boolean  "food_epipen_four"
    t.boolean  "gaurdian_one_email_corr"
    t.boolean  "gaurdian_two_email_corr"
    t.string   "allergy_description_four"
    t.string   "allergy_medication_four"
    t.string   "allergy_symptoms_four"
    t.date     "allergy_expiry_four"
    t.text     "allergy_actions_four"
    t.boolean  "allergy_epipen_four"
    t.string   "allergy_description_five"
    t.string   "allergy_medication_five"
    t.string   "allergy_symptoms_five"
    t.date     "allergy_expiry_five"
    t.text     "allergy_actions_five"
    t.boolean  "allergy_epipen_five"
    t.string   "food_description_five"
    t.string   "food_medication_five"
    t.string   "food_symptoms_five"
    t.date     "food_expiry_five"
    t.text     "food_actions_five"
    t.boolean  "food_epipen_five"
    t.string   "special_med_description_one"
    t.string   "special_med_medication_one"
    t.string   "special_med_symptoms_one"
    t.date     "special_med_expiry_one"
    t.text     "special_med_actions_one"
    t.boolean  "special_med_epipen_one"
    t.string   "gaurdian_one_employer_addr"
    t.string   "gaurdian_two_employer_addr"
    t.integer  "classroom_id"
  end

  create_table "rationales", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "full_name"
    t.text     "rational"
    t.integer  "user_id"
    t.integer  "kid_id"
    t.string   "child_name"
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "employee_id"
    t.string   "class_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "phone"
    t.string   "alt_phone"
    t.string   "title"
    t.integer  "user_id"
    t.integer  "classroom_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "daycare_location"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "admin"
    t.string   "street"
    t.string   "city"
    t.string   "province"
    t.string   "postal"
    t.string   "phone"
    t.integer  "days_absence_threshold"
    t.string   "infant_ff_rate_day"
    t.string   "toddler_ff_rate_day"
    t.string   "preschool_ff_rate_day"
    t.string   "schoolage_ff_rate_day"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
