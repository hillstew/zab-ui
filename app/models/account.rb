class Account < ApplicationRecord
  belongs_to :user

  validates_presence_of :user_id
  validates_presence_of :ynab_id
  validates_presence_of :starting_total
  validates_presence_of :interest_rate
  validates_presence_of :min_payment

  def total_months(snowball = 0, date = DateTime.now, balance = self.balance)
    count = 0
    balance = balance
    interest_rate = (self.interest_rate / 100)
    while balance > 0
      interest_paid = (interest_rate / 12) * balance
      principal_paid = (self.min_payment + snowball) - interest_paid
      balance = balance - principal_paid
      count += 1
    end
    new_date = payoff_month(count - 1, date)
    self.update(payoff_date: new_date, count: count)
    count
  end

  def payoff_month(count = 0, date = DateTime.now)
    (date + count.months).strftime("%b %Y")
  end

  def self.snowball(amount)
    ordered_accounts = ordered
    snowball = amount.to_f - ordered_accounts.total_min_payment
    count = ordered_accounts.first.total_months(snowball)
    ordered_accounts.first.update_attributes(snowball: snowball)
    ordered_accounts.each_with_index do |account, index|
      if index > 0
        balance = account.update_balance(count)
        snowball = previous_account(index).min_payment + previous_account(index).snowball
        account.update(snowball: snowball)
        payoff_month = DateTime.parse(previous_account(index).payoff_date)
        count = count += account.total_months(snowball, payoff_month, balance)
      end
    end
  end

  def self.total_min_payment
    sum(:min_payment)
  end

  def self.previous_account(index)
    ordered[index - 1]
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
        check_balance = balance - principal_paid
        break if check_balance <= 0
        balance = balance - principal_paid
      end
    balance
  end

  def self.starting_total
    @sum ||= sum(:starting_total)
  end

  def self.paid_off_percentage
    (starting_total - sum(:balance)) / starting_total * 100
  end

  def self.current_total
    starting_total - sum(:balance)
  end

  def self.debt_free_date
    last.payoff_date
  end

  def self.paid_off_accounts
    where('balance = 0')
  end

  def self.debt_accounts
    where.not('balance = 0')
  end
end
