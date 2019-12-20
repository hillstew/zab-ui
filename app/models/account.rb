class Account < ApplicationRecord
  belongs_to :user

  validates_presence_of :user_id
  validates_presence_of :ynab_id
  validates_presence_of :starting_total
  validates_presence_of :interest_rate
  validates_presence_of :min_payment

  def formatted_balance
    starting_total = self.starting_total / 1000
  end

  def total_months
    count = 0
    balance = self.balance
    while balance > 0
      # min_pay = self.balance  * (self.interest_rate / 100)
      interest_paid = self.min_payment * (self.interest_rate / 100 )
      balance = balance - (self.min_payment - interest_paid)
      count += 1
    end
    payoff_month(count)
    # binding.pry
  end

  def payoff_month(count)
    (DateTime.now + count.months).strftime("%b %Y")
  end
end
