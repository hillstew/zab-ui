class AccountsController < ApplicationController
  def new
    render locals: {
      user: UserDecorator.new(current_user)
    }
  end

  def create
    accounts = check_key
    accounts.each do |account, details|
      params = account_params(account, details)
      if (min_payment(details) - (balance(details) * (interest_rate(details) / 12))) <= 0
        min_payment_flash_message(account)
        return redirect_to signup_accounts_path
      else
        Account.create(params)
      end
    end
    redirect_to dashboard_path
  end

  def update
    service = ZabService.new
    accounts_data = service.fetch_accounts(current_user.access_token)
    x = accounts_data[:data][:accounts].find_all{|account| account[:deleted] == false}
    current_accounts = current_user.accounts
    current_accounts.each do |account|
      found = x.find do |raw_account|
        raw_account[:id] == account.ynab_id
      end
      if !found.nil?
        new_balance = (found[:cleared_balance].to_i.abs) / 1000
        account.update(balance: new_balance)
      end
    end
    redirect_to dashboard_path
  end

  private

    def min_payment_flash_message(account)
      current_user.accounts.destroy_all
      flash[:error] = "The minimum payment for #{account} is too low to cover its interest rate. Please enter a higher minimum payment."
    end

    def balance(details)
      (details['starting_total'].to_i.abs) / 1000
    end

    def min_payment(details)
      details['min_payment'].to_i
    end

    def interest_rate(details)
      ((details['interest_rate'].to_f) / 100)
    end

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
