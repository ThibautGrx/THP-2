require 'spec_helper'

describe LessonPolicy do
  subject { described_class }

  let(:user) { User.new }
  let(:created_lesson) { create(:lesson, creator: test_user) }
  let(:not_created_lesson) { create(:lesson) }

  permissions :create_classroom? do
    it "allow lesson creator to create classroom" do
      expect(subject).to permit(test_user, created_lesson)
    end
    it "denies classroom creation if not lesson creator" do
      expect(subject).not_to permit(user, created_lesson)
    end
  end

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
