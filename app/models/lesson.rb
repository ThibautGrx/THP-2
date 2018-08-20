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

class Lesson < ApplicationRecord
  belongs_to :creator, class_name: 'User', inverse_of: 'lessons'

  has_many :steps, dependent: :destroy
  has_many :classrooms, dependent: :destroy

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 300 }
end
