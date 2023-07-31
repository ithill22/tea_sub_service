class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActiveRecord::RecordInvalid, with: :render_422

  def render_404(exception)
    render json: { errors: { detail: exception.message } }, status: :not_found
  end

  def render_422(exception)
    render json: { errors: { detail: exception.message } }, status: :unprocessable_entity
  end
end
