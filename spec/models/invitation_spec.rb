# == Schema Information
#
# Table name: invitations
#
#  id           :uuid             not null, primary key
#  accepted     :boolean          default(FALSE)
#  classroom_id :uuid
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  student_id   :uuid
#  teacher_id   :uuid
#

require 'rails_helper'

RSpec.describe Invitation, type: :model do
  it "is creatable" do
    invitation = create(:invitation)
    first_invitation = Invitation.first
    expect(first_invitation.accepted).to eq(invitation.accepted)
    expect(first_invitation.student).to eq(invitation.student)
    expect(first_invitation.teacher).to eq(invitation.teacher)
    expect(first_invitation.classroom).to eq(invitation.classroom)
  end

  it "create add sending an email to queue" do
    expect{ create(:invitation) }.to change{ Sidekiq::Worker.jobs.count }.by(1)
  end

  it 'follow the student link' do
    invitation = create(:invitation).reload
    expect(invitation.student.received_invitations.first).to eq(invitation)
  end

  it 'follow the teacher link' do
    invitation = create(:invitation).reload
    expect(invitation.teacher.sent_invitations.first).to eq(invitation)
  end

  it 'follow the classroom link' do
    invitation = create(:invitation).reload
    expect(invitation.classroom.invitations.first).to eq(invitation)
  end
end
