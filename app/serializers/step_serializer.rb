# == Schema Information
#
# Table name: steps
#
#  id          :uuid             not null, primary key
#  title       :string(50)       not null
#  description :text             not null
#  lesson_id   :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class StepSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :lesson_id
end
