require 'spec_helper'

describe LessonPolicy do
  subject { LessonPolicy.new(user, lesson) }

  let(:lesson) { create(:lesson) }

  context "for a visitor" do
    let(:user) { nil }

    it { should_not permit(:show)    }
    it { should_not permit(:create)  }
    it { should_not permit(:update)  }
    it { should_not permit(:destroy) }
  end

  context "for a user" do
    let(:user) { create(:user) }

    it { should permit(:show)    }
    it { should permit(:create)  }
    it { should_not permit(:update)  }
    it { should_not permit(:destroy) }
  end

  context "for a creator" do
    let(:user) { lesson.creator }

    it { should permit(:update)  }
    it { should permit(:destroy) }
  end
end
