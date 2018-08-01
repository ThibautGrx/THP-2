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

class InvitationSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :classroom_id, :created_at, :accepted
end
