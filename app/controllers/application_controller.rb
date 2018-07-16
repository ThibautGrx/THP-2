class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery
  include Pundit

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

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  def not_authorized
    render json: { errors: "You are not authorized to perform this action." }, status: :unauthorized
  end
end
