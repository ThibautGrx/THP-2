# == Schema Information
#
# Table name: lessons
#
#  id          :uuid             not null, primary key
#  title       :string(50)       not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creator_id  :uuid
#  user_id     :integer
#

class LessonSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :creator
end
