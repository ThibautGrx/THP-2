require 'spec_helper'

describe InvitationPolicy do
  subject { described_class }

  let!(:classroom) { create(:classroom) }
  let!(:classroom_creator) { classroom.creator }
  let!(:random_user) { create(:user) }
  let(:other_invitation) { create(:invitation) }
  let(:new_invitation) { build(:invitation, classroom: classroom, teacher: classroom_creator) }
  let(:invitation) { create(:invitation, student: test_user, classroom: classroom) }

  permissions :update? do
    it "allow classroom invitee to update his invitation" do
      expect(subject).to permit(test_user, invitation)
    end
    it "denies update on other invitation" do
      expect(subject).not_to permit(test_user, other_invitation)
    end
  end

  permissions :create? do
    it "allow teacher to create invitation" do
      expect(subject).to permit(classroom_creator, new_invitation)
    end
    it "denies create other classroom invitation" do
      expect(subject).not_to permit(random_user, new_invitation)
    end
  end

  permissions :destroy? do
    it "allow  creator to delete his invitation" do
      expect(subject).to permit(invitation.teacher, invitation)
    end
    it "allow student to delete invitation" do
      expect(subject).to permit(test_user, invitation)
    end
    it "denies delete on other invitation" do
      expect(subject).not_to permit(test_user, other_invitation)
    end
  end
end
