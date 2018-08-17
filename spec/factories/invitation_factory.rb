# == Schema Information
#
# Table name: invitations
#
#  id           :uuid             not null, primary key
#  accepted     :boolean          default(FALSE)
#  classroom_id :uuid
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  student_id   :uuid
#  teacher_id   :uuid
#

FactoryBot.define do
  factory :invitation do
    accepted false
    student { create(:user) }
    teacher { create(:user) }
    classroom { create(:classroom) }

    trait :accepted do
      accepted true
    end
  end
end
