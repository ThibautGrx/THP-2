class WebsocketsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.generate_token
  end
end
