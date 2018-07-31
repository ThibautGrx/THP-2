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
#  user_id     :integer
#

FactoryBot.define do
  factory :lesson do
    title { Faker::Beer.name }
    description { Faker::ChuckNorris.fact }
    creator { create(:user) }

    trait :with_classrooms do
      after :create do |lesson|
        create_list(:classroom, Random.rand(3..7), lesson: lesson, creator: lesson.creator )
      end
    end
  end
end
