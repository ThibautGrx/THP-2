# == Schema Information
#
# Table name: lessons
#
#  id          :uuid             not null, primary key
#  title       :string(50)       not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Lesson < ApplicationRecord
  validates :title, :description, presence: true
  validates :title, length: { maximum: 50 }
  validates :description, length: { maximum: 300 }

  belongs_to :creator,
             class_name: "User",
             foreign_key: "user_id",
             inverse_of: 'created_lessons'
end
