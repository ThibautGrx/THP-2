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

class TickedStepSerializer < ActiveModel::Serializer
  attributes :id, :classroom_id, :user_id, :step_id
end
