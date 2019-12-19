class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    code = params["code"]

    response = Faraday.post("https://app.youneedabudget.com/oauth/token?client_id=#{ENV['CLIENT_ID']}&client_secret=#{ENV['CLIENT_SECRET']}&redirect_uri=http://localhost:3000/auth/ynab/callback&grant_type=authorization_code&code=#{code}")
    raw_token_data = JSON.parse(response.body, symbolize_names: true)
    user = User.create!(access_token: raw_token_data[:access_token], refresh_token: raw_token_data[:refresh_token], last_login: DateTime.now)
    session[:user_id] = user.id
    redirect_to signup_profile_path
  end

  def update
    user = current_user.update!(user_params)
    redirect_to signup_accounts_path
  end

  def edit
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
