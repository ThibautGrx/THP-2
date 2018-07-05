# == Schema Information
#
# Table name: lessons
#
#  id          :uuid             not null, primary key
#  title       :string(50)       not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it "is creatable" do
    lesson = create(:lesson)
    first_lesson = Lesson.first
    expect(first_lesson.title).to eq(lesson.title)
    expect(first_lesson.description).to eq(lesson.description)
  end

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  it { should validate_length_of(:title).is_at_most(50) }
  it { should validate_length_of(:description).is_at_most(300) }
end
