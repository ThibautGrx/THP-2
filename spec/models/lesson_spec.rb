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
  pending "add some examples to (or delete) #{__FILE__}"
end
