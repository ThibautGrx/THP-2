# == Schema Information
#
# Table name: questions
#
#  id           :uuid             not null, primary key
#  body         :text             not null
#  classroom_id :uuid
#  user_id      :uuid
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Question < ApplicationRecord
  belongs_to :classroom
  belongs_to :user
  has_many :votes, dependent: :destroy
  has_many :upvoting_users, through: :votes, source: :user

  validates :body, presence: true, length: { maximum: 300 }
end
