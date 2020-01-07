class AccountsController < ApplicationController
  def new
    render locals: {
      user: UserDecorator.new(current_user)
    }
  end

  def create
    params['accounts'].each do |account, details|
      check_key(account, details)
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

    def check_key(account, details)
      if details.has_key?('checked')
        params = account_params(account, details)
        account = Account.create(params)
      end
    end
end
