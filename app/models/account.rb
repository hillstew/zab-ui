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

  def total_months
    count = 0
    balance = self.balance
    interest_rate = (self.interest_rate / 100)

    while balance > 0
      interest_paid = (interest_rate / 12) * balance
      principal_paid = self.min_payment - interest_paid
      balance = balance - principal_paid
      count += 1
    end
    payoff_month(count)
  end

  def payoff_month(count)
    (DateTime.now + count.months).strftime('%b %Y')
  end
end
