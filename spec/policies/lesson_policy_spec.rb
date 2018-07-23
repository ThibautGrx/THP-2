require 'spec_helper'

describe LessonPolicy do
  subject { LessonPolicy.new(user, lesson) }

  let(:lesson) { create(:lesson) }

  context "for a creator" do
    let(:user) { lesson.creator }

    it { should permit(:update)  }
    it { should permit(:destroy) }
  end
end
