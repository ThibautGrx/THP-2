# == Schema Information
#
# Table name: invitations
#
#  id           :uuid             not null, primary key
#  is_accepted  :boolean
#  user_id      :uuid
#  classroom_id :uuid
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Invitation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
