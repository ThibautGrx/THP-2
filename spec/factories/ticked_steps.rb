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
  factory :ticked_step do
    step { create(:step) }
    user { create(:user) }
    classroom { create(:classroom) }
  end
end
