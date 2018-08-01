require 'spec_helper'

describe InvitationPolicy do
  subject { described_class }

  let(:new_invitation) { build(:invitation) }
  let(:invitation) { create(:invitation, user: test_user) }
  let(:other_invitation) { create(:invitation) }

  permissions :update? do
    it "allow classroom invitee to update his invitation" do
      expect(subject).to permit(test_user, invitation)
    end
    it "denies update on other invitation" do
      expect(subject).not_to permit(test_user, other_invitation)
    end
  end

  permissions :create? do
    it "allow classroom creator to create invitation" do
      expect(subject).to permit(new_invitation.classroom.creator, new_invitation)
    end
    it "denies create other classroom invitation" do
      expect(subject).not_to permit(test_user, new_invitation)
    end
  end

  permissions :destroy? do
    it "allow classroom creator to delete his invitation" do
      expect(subject).to permit(invitation.classroom.creator, invitation)
    end
    it "allow invitee to delete invitation" do
      expect(subject).to permit(test_user, invitation)
    end
    it "denies delete on other invitation" do
      expect(subject).not_to permit(test_user, other_invitation)
    end
  end
end
