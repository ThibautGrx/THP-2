# == Schema Information
#
# Table name: questions
#
#  id           :uuid             not null, primary key
#  body         :text             not null
#  classroom_id :uuid
#  user_id      :uuid
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryBot.define do
  factory :question do
    body "MyText"
    classroom nil
    user nil
  end
end
