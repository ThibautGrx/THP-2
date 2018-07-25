# == Schema Information
#
# Table name: questions
#
#  id           :uuid             not null, primary key
#  body         :text
#  classroom_id :uuid
#  user_id      :uuid
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Question, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
