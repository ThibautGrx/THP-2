# == Schema Information
#
# Table name: classrooms
#
#  id          :uuid             not null, primary key
#  title       :string(50)       not null
#  description :text             not null
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

    trait :with_invitations do
      after(:create) do |classroom|
        create_list(:invitation, 5, accepted: true, classroom: classroom)
        create_list(:invitation, 5, accepted: false, classroom: classroom)
      end
    end
  end
end
