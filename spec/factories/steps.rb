# == Schema Information
#
# Table name: steps
#
#  id          :uuid             not null, primary key
#  title       :string
#  description :text
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
