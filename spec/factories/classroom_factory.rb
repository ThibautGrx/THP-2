# == Schema Information
#
# Table name: classrooms
#
#  id          :uuid             not null, primary key
#  title       :string
#  description :text
#  lesson_id   :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creator_id  :uuid
#

FactoryBot.define do
  factory :classroom do
    title { Faker::Beer.name }
    description { Faker::ChuckNorris.fact }
    creator { create(:user) }
    lesson { create(:lesson) }
  end
end
