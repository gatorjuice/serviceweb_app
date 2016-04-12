FactoryGirl.define do
  factory :users do
    first_name "John"
    last_name "Doe"
    sequence(:email) { |n| "johndoe#{n}@example.com" }
    
  end
end

# t.string   "email",                  default: "",    null: false
# t.string   "encrypted_password",     default: "",    null: false
# t.string   "reset_password_token"
# t.datetime "reset_password_sent_at"
# t.datetime "remember_created_at"
# t.integer  "sign_in_count",          default: 0,     null: false
# t.datetime "current_sign_in_at"
# t.datetime "last_sign_in_at"
# t.inet     "current_sign_in_ip"
# t.inet     "last_sign_in_ip"
# t.datetime "created_at",                             null: false
# t.datetime "updated_at",                             null: false
# t.string   "first_name"
# t.string   "last_name"
# t.boolean  "admin",                  default: false
# t.text     "description"