# == Schema Information
#
# Table name: invitations
#
#  id           :uuid             not null, primary key
#  accepted     :boolean          default(FALSE)
#  user_id      :uuid
#  classroom_id :uuid
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryBot.define do
  factory :invitation do
    accepted false
    user { create(:user) }
    classroom { create(:classroom) }

    trait :accepted do
      accepted true
    end
  end
end
