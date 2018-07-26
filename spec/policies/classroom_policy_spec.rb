require 'spec_helper'

describe ClassroomPolicy do
  subject { ClassroomPolicy.new(user, classroom) }

  let(:classroom) { create(:classroom) }

  context "for a creator" do
    let(:user) { classroom.teacher }

    it { should permit(:update)  }
    it { should permit(:destroy) }
  end
end
