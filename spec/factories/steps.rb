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
    title "MyString"
    description "MyText"
    lesson nil
  end
end
