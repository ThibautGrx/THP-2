# == Schema Information
#
# Table name: votes
#
#  id          :uuid             not null, primary key
#  user_id     :uuid
#  question_id :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Vote < ApplicationRecord
  belongs_to :question
  belongs_to :user
end
