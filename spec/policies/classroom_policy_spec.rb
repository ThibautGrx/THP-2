require 'spec_helper'

describe ClassroomPolicy do
  subject { described_class }

  let(:user) { User.new }
  let(:created_classroom) { create(:classroom, creator: test_user) }
  let(:not_created_classroom) { create(:classroom) }

  permissions :update? do
    it "allow creator to update his  classroom" do
      expect(subject).to permit(test_user, created_classroom)
    end
    it "denies update on other  classroom" do
      expect(subject).not_to permit(test_user, not_created_classroom)
    end
  end

  permissions :destroy? do
    it "allow creator to delete his  classroom" do
      expect(subject).to permit(test_user, created_classroom)
    end
    it "denies delete on other  classroom" do
      expect(subject).not_to permit(test_user, not_created_classroom)
    end
  end
end
