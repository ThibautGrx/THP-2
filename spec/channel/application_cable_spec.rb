require "rails_helper"

RSpec.describe ApplicationCable::Connection, type: :channel do
  before { test_user.generate_token }

  it "successfully connects" do
    connect "/cable/#{test_user.token.first}"
    expect(connection.current_user).to eq(test_user)
  end
end
