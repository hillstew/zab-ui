class Dashboard::SnowballController < ApplicationController
  def index
    response = current_user.accounts.last
    response.min_payment = 1000
    response.save
    render json: response
  end
end
