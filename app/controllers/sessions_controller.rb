class SessionsController < ApplicationController
def create
    @user = User.find_by(email: session_params[:usernameOrEmail])
    unless @user
      @user = User.find_by(username: session_params[:usernameOrEmail])
    end

    if @user && @user.authenticate(session_params[:password])
      login!
      render json: {
        logged_in: true,
        user: @user,
        session: session,
        production: Rails.env.production?

      }
    else
      render json: {
        status: 401,
        errors: ['no such user', 'verify credentials and try again or signup']
      }
    end
  end
def is_logged_in?
    if logged_in? && current_user
      render json: {
        logged_in: true,
        user: current_user
      }
    else
      render json: {
        session: session[:user_id],
        logged_in: false,
        message: 'no such user'
      }
    end
  end
def destroy
    logout!
    render json: {
      status: 200,
      logged_out: true
    }
  end
private
def session_params
    params.require(:user).permit(:usernameOrEmail, :password)
  end
end
