FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username{ Faker::Internet.user_name }
    password { Faker::Internet.password(8) }
    password_confirmation { password }
  end
end
