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
end
