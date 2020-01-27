class UsersController < ApplicationController
  def create
    if current_user && !current_user.accounts.empty?
      redirect_to :controller => 'accounts', :action => 'update'
      # redirect_to dashboard_path
    else
      new_or_returing_user
    end
  end

  def edit; end

  private

  def user_data
    {
      email: request.env['omniauth.auth']["info"]["email"],
      first_name: request.env['omniauth.auth']["info"]["first_name"],
      last_name: request.env['omniauth.auth']["info"]["last_name"],
      image: request.env['omniauth.auth']["info"]["image"],
      google_token: request.env['omniauth.auth']["credentials"]["token"],
      last_login: DateTime.now
    }
  end

  def user_creation
    new_user = User.create(user_data)
    session[:user_id] = new_user.id
  end

  def restore_session(user)
    session[:user_id] = user.id
    user.update(last_login: DateTime.now)
  end

  def new_or_returing_user
    user = User.find_by(email: user_data[:email])
    if user.nil?
      user_creation
      redirect_to signup_ynab_path
    elsif user.accounts.empty?
      restore_session(user)
      redirect_to signup_ynab_path
    else
      restore_session(user)
      redirect_to :controller => 'accounts', :action => 'update'
      # redirect_to dashboard_path
    end
  end
end
