class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    tokens = YnabService.new.fetch_tokens(params['code'])
    user_data = format_user_data(tokens)
    user = User.create!(user_data)
    session[:user_id] = user.id
    redirect_to signup_profile_path
  end

  def update
    current_user.update!(user_params)
    redirect_to signup_accounts_path
  end

  def edit
    @user = current_user
  end

  private

  def format_user_data(raw_token_data)
    {
      access_token: raw_token_data[:access_token],
      refresh_token: raw_token_data[:refresh_token],
      last_login: DateTime.now
    }
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
