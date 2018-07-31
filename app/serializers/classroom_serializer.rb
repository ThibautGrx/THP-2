# == Schema Information
#
# Table name: classrooms
#
#  id          :uuid             not null, primary key
#  title       :string
#  description :text
#  lesson_id   :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creator_id  :uuid
#

class ClassroomSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :creator_id, :lesson_id
end
