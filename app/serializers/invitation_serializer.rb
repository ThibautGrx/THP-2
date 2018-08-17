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

class InvitationSerializer < ActiveModel::Serializer
  attributes :id, :student_id, :teacher_id, :classroom_id, :created_at, :accepted
end
