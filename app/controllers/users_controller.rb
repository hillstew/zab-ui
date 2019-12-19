class UsersController < ApplicationController 
  def new
    @user = User.new
  end

  def create
    user_params = params[:user]
    url = "https://app.youneedabudget.com/oauth/authorize?client_id=#{ENV["CLIENT_ID"]}&redirect_uri=http://localhost:3000/auth/ynab/callback&response_type=code"
    code = params["code"]

    if params["code"]
      redirect_to url
    end

    response = Faraday.post("https://app.youneedabudget.com/oauth/token?client_id=#{ENV['CLIENT_ID']}&client_secret=#{ENV['CLIENT_SECRET']}&redirect_uri=http://localhost:3000/auth/ynab/callback&grant_type=authorization_code&code=#{params["code"]}")

    binding.pry
  end
end