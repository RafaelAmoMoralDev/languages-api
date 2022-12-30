class ApplicationController < ActionController::API

  before_action :authenticate_with_token
  before_action :authenticate_with_token!


  def initialization
    render json: @current_user, status: :ok
  end

  private

  def authenticate_with_token
    @current_user ||= User.find_by_password_digest(request.headers['Authorization']) unless request.headers['Authorization'].blank?
  end

  def authenticate_with_token!
    authenticate_with_token
    render json: { code: 0, causes: ['The Authorization key in header is not present or is incorrect'] }, status: :unauthorized unless @current_user.present?
  end

end
