class Account < ApplicationRecord
  belongs_to :user

  validates_presence_of :user_id
  validates_presence_of :ynab_id
  validates_presence_of :starting_total
  validates_presence_of :interest_rate
  validates_presence_of :min_payment

  def formatted_balance
    self.starting_total / 1000
  end

  def total_months(snowball = 0, date = DateTime.now)
    count = 0
    balance = self.balance
    interest_rate = (self.interest_rate / 100)
    while balance > 0
      interest_paid = (interest_rate / 12) * balance
      principal_paid = (self.min_payment + snowball) - interest_paid
      balance = balance - principal_paid
      count += 1
    end
    new_date = payoff_month(count - 1, date)
    self.update(payoff_date: new_date)
    count - 1
  end

  def payoff_month(count, date)
    (date + count.months).strftime("%b %Y")
  end

  def self.snowball(amount)
    ordered_accounts = ordered
    total_payments = ordered_accounts.sum(:min_payment)
    snowball = amount.to_f - total_payments
    count = ordered_accounts.first.total_months(snowball)
    ordered_accounts.first.update_attributes(snowball: snowball)
    ordered_accounts.each_with_index do |account, index|
      if index > 0
        previous_account = ordered_accounts[index - 1]
        num_of_months = Time.now.month - DateTime.parse(previous_account.payoff_date)
        binding.pry
        account.update_balance(count)
        snowball = previous_account.min_payment + previous_account.snowball
        payoff_month = DateTime.parse(ordered_accounts[index - 1].payoff_date)
        count = account.total_months(snowball, payoff_month)
        # account.payoff_month(count, payoff_month)
        # account.update(payoff_date: payoff_date)
      end
    end
    binding.pry
  end

  def self.ordered
    order(:balance)
  end

  def update_balance(count)
    balance = self.balance
    interest_rate = (self.interest_rate / 100)
    count.times do |i|
      interest_paid = (interest_rate / 12) * balance
      principal_paid = self.min_payment - interest_paid
      balance = balance - principal_paid
    end
    self.update(balance: balance)
  end
end
