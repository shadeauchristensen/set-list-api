class ApplicationController < ActionController::API
  def authenticate_user
    key = request.headers["Authorization"]

    @current_user = User.find_by(api_token: key)

    # intervene and render error
    render json: {
      error: "Unauthorized, please register as a user"
    }, status: :unauthorized if @current_user.nil?
  end
end
