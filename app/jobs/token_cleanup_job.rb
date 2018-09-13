class TokenCleanupJob < ApplicationJob
  queue_as :default

  def perform(user)
    user.token.clear if user.token.any?
    user.save
  end
end
