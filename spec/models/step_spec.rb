# == Schema Information
#
# Table name: steps
#
#  id          :uuid             not null, primary key
#  title       :string(50)       not null
#  description :text             not null
#  lesson_id   :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Step, type: :model do
  it "is creatable" do
    step = create(:step)
    first_step = Step.first
    expect(first_step.title).to eq(step.title)
    expect(first_step.description).to eq(step.description)
  end

  it "follows lesson link" do
    step = create(:step).reload
    expect(step.lesson.steps.first).to eq(step)
  end

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }

  it { is_expected.to validate_length_of(:title).is_at_most(50) }
  it { is_expected.to validate_length_of(:description).is_at_most(300) }
end
