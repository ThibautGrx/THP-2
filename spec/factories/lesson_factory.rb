# == Schema Information
#
# Table name: lessons
#
#  id          :uuid             not null, primary key
#  title       :string(50)       not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creator_id  :uuid
#

FactoryBot.define do
  factory :lesson do
    association :creator, factory: :user
    title { Faker::Beer.name }
    description { Faker::ChuckNorris.fact }
    creator { create(:user) }
  end
end
