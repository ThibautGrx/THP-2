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

class TickedStepSerializer < ActiveModel::Serializer
  attributes :id, :classroom_id, :user_id, :step_id
end
