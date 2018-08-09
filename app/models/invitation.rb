# == Schema Information
#
# Table name: invitations
#
#  id           :uuid             not null, primary key
#  accepted     :boolean          default(FALSE)
#  user_id      :uuid
#  classroom_id :uuid
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :classroom
end
