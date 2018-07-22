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
#

class Lesson < ApplicationRecord
<<<<<<< HEAD
  validates :title, :description, presence: true
  validates :title, length: { maximum: 50 }
  validates :description, length: { maximum: 300 }

  belongs_to :creator,
             class_name: "User",
             foreign_key: "user_id",
             inverse_of: 'created_lessons'
=======
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 300 }

  belongs_to :creator, class_name: 'User', inverse_of: 'lessons'
>>>>>>> ca72ccb2324edbfa905051b10b2d420266879232
end
