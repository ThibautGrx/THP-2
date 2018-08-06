# == Schema Information
#
# Table name: classrooms
#
#  id          :uuid             not null, primary key
#  title       :string(50)       not null
#  description :text             not null
#  lesson_id   :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creator_id  :uuid
#

require 'rails_helper'

RSpec.describe Classroom, type: :model do
  it "is creatable" do
    classroom = create(:classroom)
    first_classroom = Classroom.first
    expect(first_classroom.title).to eq(classroom.title)
    expect(first_classroom.description).to eq(classroom.description)
  end

  it "follows creator link" do
    classroom = create(:classroom).reload
    expect(classroom.creator.classrooms.first).to eq(classroom)
  end

  it "follows lesson link" do
    classroom = create(:classroom).reload
    expect(classroom.lesson.classrooms.first).to eq(classroom)
  end

  it { is_expected.to validate_presence_of(:lesson) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }

  it { is_expected.to validate_length_of(:title).is_at_most(50) }
  it { is_expected.to validate_length_of(:description).is_at_most(300) }
end
