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

class Invitation < ApplicationRecord
  belongs_to :student, class_name: 'User', inverse_of: 'received_invitations'
  belongs_to :teacher, class_name: 'User', inverse_of: 'sent_invitations'
  belongs_to :classroom

  validates :student, presence: true
  validates :teacher, presence: true
  validates :classroom, presence: true
end
