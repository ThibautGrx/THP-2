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

class TickedStep < ApplicationRecord
  belongs_to :classroom
  belongs_to :user
  belongs_to :step

  after_commit :broadcast_to_classroom_create, on: :create
  after_destroy :broadcast_to_classroom_delete

  def broadcast_to_classroom_create
    type = "STEP_TICKED"
    ClassroomChannel.broadcast_to(classroom, message(type))
  end

  def broadcast_to_classroom_delete
    type = "STEP_UNTICKED"
    ClassroomChannel.broadcast_to(classroom, message(type))
  end

  def message(type)
    value = { lesson_id: classroom.lesson.id, step_id: step.id, completness_percentage: step.completness_percentage(classroom) }
    {
      type: type,
      value: value
    }.to_json
  end
end
