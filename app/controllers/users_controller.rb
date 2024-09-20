class UsersController < ActionController::Base
    def new
      @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to @user
        else
            render :new
        end
    end

    def show
        @user = User.find(params[:id])
    end

    def login_form
    end

    def login
        user = User.find_by(email: params[:email])
        if user.authenticate(params[:password])
          redirect_to user
        else
          render :login_form
        end
    end
    
    private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end