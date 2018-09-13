class WebsocketsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.generate_token
    redirect_to "/cable/#{current_user.token.first}"
  end
end
