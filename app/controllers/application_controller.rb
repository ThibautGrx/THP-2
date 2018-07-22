class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  include DeviseTokenAuth::Concerns::SetUserByToken
<<<<<<< HEAD
  protect_from_forgery
  include Pundit
=======
  before_action :configure_permitted_parameters, if: :devise_controller?
>>>>>>> ca72ccb2324edbfa905051b10b2d420266879232

  rescue_from ActionController::ParameterMissing, with: :rescue_param_missing
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :rescue_bad_params

  def record_not_found(exception)
    render json: { errors: [{ detail: exception.message }] }, status: :not_found
  end

  def rescue_param_missing(exception)
    render json: { errors: [exception.message] }, status: :forbidden
  end

  def rescue_bad_params(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :forbidden
  end

<<<<<<< HEAD
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  def not_authorized
    render json: { errors: "You are not authorized to perform this action." }, status: :unauthorized
=======
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email])
>>>>>>> ca72ccb2324edbfa905051b10b2d420266879232
  end
end
