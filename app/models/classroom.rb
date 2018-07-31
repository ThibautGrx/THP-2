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

class Classroom < ApplicationRecord
  has_many :invitations, dependent: :destroy
  has_many :accepted_invitations,
           -> { where "accepted = true" },
           class_name: "Invitation",
           inverse_of: false
  has_many :pending_invitations,
           -> { where "accepted = false" },
           class_name: "Invitation",
           inverse_of: false
  has_many :students, through: :accepted_invitations, source: :user
  has_many :invitees, through: :pending_invitations, source: :user
  has_many :users, through: :invitations, source: :user
  has_many :questions, dependent: :destroy
  has_many :ticked_steps, dependent: :destroy
  has_many :steps, through: :ticked_steps

  belongs_to :lesson
  belongs_to :creator, class_name: 'User', inverse_of: 'classrooms'

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :lesson, presence: true
end
