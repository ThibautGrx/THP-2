# == Schema Information
#
# Table name: ticked_steps
#
#  id           :uuid             not null, primary key
#  step_id      :uuid
#  user_id      :uuid
#  classroom_id :uuid
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryBot.define do
  factory :ticked_step do
    step { create(:step) }
    user { create(:user) }
    classroom { create(:classroom) }
  end
end
