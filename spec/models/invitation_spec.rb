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

require 'rails_helper'

RSpec.describe Invitation, type: :model do
  it "is creatable" do
    invitation = create(:invitation)
    first_invitation = Invitation.first
    expect(first_invitation.accepted).to eq(invitation.accepted)
    expect(first_invitation.user).to eq(invitation.user)
    expect(first_invitation.classroom).to eq(invitation.classroom)
  end

  it 'follow the user link' do
    invitation = create(:invitation).reload
    expect(invitation.user.invitations.first).to eq(invitation)
  end

  it 'follow the classroom link' do
    invitation = create(:invitation).reload
    expect(invitation.classroom.invitations.first).to eq(invitation)
  end
end
