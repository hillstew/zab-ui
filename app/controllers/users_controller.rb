class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if current_user
      redirect_to dashboard_path
    else
      user = User.find_by(email: user_data[:email])
      if user.nil?
        new_user = User.create(user_data)
        session[:user_id] = new_user.id
        redirect_to signup_ynab_path
      else
        session[:user_id] = user.id
        redirect_to dashboard_path
      end
    end
  end

  private

  def user_data
    {
      email: request.env['omniauth.auth']["info"]["email"],
      first_name: request.env['omniauth.auth']["info"]["first_name"],
      last_name: request.env['omniauth.auth']["info"]["last_name"],
      image: request.env['omniauth.auth']["info"]["image"],
      google_token: request.env['omniauth.auth']["credentials"]["token"]
    }
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
