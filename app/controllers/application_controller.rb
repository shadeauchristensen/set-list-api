class ApplicationController < ActionController::API
  def authenticate_user
    token = request.headers['Authorization']
    @current_user = User.find_by(api_token: token)

    render json: { error: 'Unathorized, please register as a user' }, status: :unauthorized unless @current_user
  end

  def require_admin
    render status: :method_not_allowed unless @current_user.admin?
  end
end
