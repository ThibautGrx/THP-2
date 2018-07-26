# == Schema Information
#
# Table name: classrooms
#
#  id          :uuid             not null, primary key
#  title       :string
#  description :text
#  lesson_id   :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Classroom, type: :model do
  it "is creatable" do
    classroom = create(:classroom)
    first_classroom = Classroom.first
    expect(first_classroom.title).to eq(classroom.title)
    expect(first_classroom.description).to eq(classroom.description)
    expect(first_classroom.lesson).to eq(classroom.lesson)
  end

  it { is_expected.to belong_to(:lesson) }
  it { is_expected.to have_many(:invitations) }
  it { is_expected.to have_many(:students) }
  it { is_expected.to have_many(:questions) }
  it { is_expected.to have_many(:ticked_steps) }
  it { is_expected.to have_many(:steps) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }

  it { is_expected.to validate_length_of(:title).is_at_most(50) }
  it { is_expected.to validate_length_of(:description).is_at_most(300) }
end
