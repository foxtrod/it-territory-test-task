class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::ParameterMissing, with: :invalid_request

  def render_unprocessable_entity(errors)
    render json: { errors: errors, code: 'validation_error' },
           status: :unprocessable_entity
  end

  def render_not_found(error)
    render json: { errors: error.exception, code: 'not_found' },
           status: :not_found
  end

  def invalid_request(error)
    render json: { errors: error.exception, code: 'invalid_request' },
           status: :bad_request
  end

  def invalid_record(error)
    render json: { errors: error.exception, code: 'validation_error' },
           status: :unprocessable_entity
  end
end
