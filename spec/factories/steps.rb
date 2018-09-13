# == Schema Information
#
# Table name: steps
#
#  id          :uuid             not null, primary key
#  title       :string(50)       not null
#  description :text             not null
#  lesson_id   :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :step do
    title { Faker::Beer.name }
    description { Faker::ChuckNorris.fact }
    lesson { create(:lesson) }
  end
end
