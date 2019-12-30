class DashboardController < ApplicationController
  def index
    @accounts = current_user.accounts
  end
end
