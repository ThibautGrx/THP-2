require 'rails_helper'

RSpec.describe User, type: :model do
  it "is creatable" do
    user = create(:user)
    first_user = User.first
    expect(first_user.username).to eq(user.username)
    expect(first_user.email).to eq(user.email)
  end
end
