class DashboardController < ApplicationController
  def index
    @accounts = current_user.accounts.ordered
  end
end
