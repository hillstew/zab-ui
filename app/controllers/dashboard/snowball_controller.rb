class Dashboard::SnowballController < ApplicationController
  def index
    response = current_user.accounts.snowball(params[:amount])
    render json: response
  end
end
