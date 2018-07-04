# == Schema Information
#
# Table name: lessons
#
#  id          :uuid             not null, primary key
#  title       :string
#  description :text
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
end
