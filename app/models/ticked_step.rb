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
    value = { lesson_id: classroom.lesson.id, step_id: step, completness_percentage: step.completness_percentage }.to_json
    message = {
      type: "STEP_TICKED",
      value: value.to_json
    }.to_json
    ActionCable.server.broadcast(classroom, message)
  end

  def broadcast_to_classroom_delete
    value = { lesson_id: classroom.lesson.id, step_id: step, completness_percentage: step.completness_percentage }.to_json
    message = {
      type: "STEP_UNTICKED",
      value: value.to_json
    }.to_json
    ActionCable.server.broadcast(classroom, message)
  end
end
