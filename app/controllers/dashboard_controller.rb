class DashboardController < ApplicationController
  def index
    if current_user.snowball_amount == 0
      @accounts = current_user.accounts.ordered
    else
      @accounts = current_user.accounts.debt_accounts.snowball(current_user.snowball_amount)
    end
  end
end
