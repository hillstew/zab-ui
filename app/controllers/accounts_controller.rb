class AccountsController < ApplicationController
  def new
    render locals: {
      user: UserDecorator.new(current_user)
    }
  end

  def create
    accounts = check_key

    accounts.each do |account, details|
      balance = (details['starting_total'].to_i.abs) / 1000
      min_payment = details['min_payment'].to_i
      interest_rate = ((details['interest_rate'].to_f) / 100)
      params = account_params(account, details)

      if (min_payment - (balance * (interest_rate / 12))) <= 0
        current_user.accounts.destroy_all
        flash[:error] = "The minimum payment for #{account} is too low to cover its interest rate. Please enter a higher minimum payment."
        return redirect_to signup_accounts_path
      else
        Account.create(params)
      end
    end

    redirect_to dashboard_path
  end

  private
    def account_params(account, details)
      {
        name: account,
        user_id: current_user.id,
        ynab_id: details['ynab_id'],
        min_payment: details['min_payment'].to_f,
        starting_total: details['starting_total'].to_f.abs / 1000,
        interest_rate: details['interest_rate'].to_f,
        balance: (details['starting_total'].to_f.abs / 1000)
      }
    end

    def check_key
      accounts = {}

      params['accounts'].each do |account, details|
        if details.has_key?('checked')
          accounts[account] = details
        end
      end

      accounts
    end
end
