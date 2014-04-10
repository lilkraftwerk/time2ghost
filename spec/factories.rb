FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    password { Faker::Internet.password(6) }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }
  end
end