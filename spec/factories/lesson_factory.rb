FactoryBot.define do
  factory :lesson do
    title { Faker::DrWho.catch_phrase }
    description { Faker::ChuckNorris.fact }
  end
end
