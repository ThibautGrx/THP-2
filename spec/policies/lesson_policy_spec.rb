require 'spec_helper'

describe LessonPolicy do
  subject { described_class }

  let(:user) { User.new }
  let(:created_lesson) { create(:lesson, creator: test_user) }
  let(:not_created_lesson) { create(:lesson) }

  permissions :update? do
    it "allow creator to update his lesson" do
      expect(subject).to permit(test_user, created_lesson)
    end
    it "denies update on other lesson" do
      expect(subject).not_to permit(test_user, not_created_lesson)
    end
  end

  permissions :destroy? do
    it "allow creator to delete his lesson" do
      expect(subject).to permit(test_user, created_lesson)
    end
    it "denies delete on other lesson" do
      expect(subject).not_to permit(test_user, not_created_lesson)
    end
  end
end
