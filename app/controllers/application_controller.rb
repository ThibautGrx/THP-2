class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found(exception)
    render json: { errors: [{ detail: exception.message }] }, status: :not_found
  end

  before_action :set_raven_context

  private

  def set_raven_context
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
