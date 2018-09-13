class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  include DeviseTokenAuth::Concerns::SetUserByToken

  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActionController::ParameterMissing, with: :rescue_param_missing
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :rescue_bad_params
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  def record_not_found(exception)
    render json: { errors: [{ detail: exception.message }] }, status: :not_found
  end

  def rescue_param_missing(exception)
    render json: { errors: [exception.message] }, status: :forbidden
  end

  def rescue_bad_params(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :forbidden
  end

  def not_authorized
    render json: { errors: "You are not authorized to perform this action." }, status: :unauthorized
  end

  def pagination_dict(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.prev_page,
      total_pages: collection.total_pages,
      total_count: collection.total_count
    }
  end

  private

  def page_params
    @page_params ||=
      begin
        new_page_params = params.permit(:number, :size)
        new_page_params[:size] ||= 25
        new_page_params[:size] = new_page_params[:size].to_i
        new_page_params[:size] = 25 if new_page_params[:size] > 100
        new_page_params
      end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email])
  end
end
