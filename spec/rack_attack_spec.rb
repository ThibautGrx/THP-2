require 'rails_helper'

RSpec.describe Rack::Attack do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  context "too many request on the same path" do
    it "should respond with 429 Too many request" do
      301.times do
        get "/auth/sign_in", session: { "REMOTE_ADDR" => "1.2.3.4" }
      end
      expect(last_response.status).to eq(429)
    end
  end

  context "throttle excessive POST requests to user sign in by IP address" do
    it "should respond with 429 Too many request" do
      6.times do |i|
        post "/auth/sign_in", params: { login: "example1#{i}@gmail.com" }, session: { "REMOTE_ADDR" => "1.2.3.6" }
      end
      expect(last_response.status).to eq(429)
    end
  end

  context "throttle excessive POST requests to user sign in by email" do
    it "should respond with 429 Too many request" do
      6.times do |i|
        post "/auth/sign_in", params: { login: "example@gmail.com" }, session: { "REMOTE_ADDR" => "#{i}.4.5.6" }
      end
      expect(last_response.status).to eq(429)
    end
  end
end
