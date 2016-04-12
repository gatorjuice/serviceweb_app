FactoryGirl.define do
  factory :resource do
    sequence(:name) { |n| "test resource #{n}" }
    address "1400 N Greenleaf, Chicago, IL"
    street Faker::Address.street_address
    city Faker::Address.city
    state Faker::Address.state_abbr
    zip_code Faker::Address.zip_code
    Faker::Config.locale = 'en-US'
    phone Faker::PhoneNumber.area_code + Faker::PhoneNumber.exchange_code + Faker::PhoneNumber.subscriber_number   
    description Faker::Lorem.paragraph
    food [true, false].sample
    health [true, false].sample
    shelter [true, false].sample
    user_id 1
    latitude Faker::Address.latitude
    longitude Faker::Address.longitude
  end
end

    # t.datetime "created_at",                         null: false
    # t.datetime "updated_at",                         null: false
    # t.string   "status",      default: "unverified"
    # t.integer  "shares"