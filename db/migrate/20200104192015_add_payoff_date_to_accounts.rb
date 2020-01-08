class AddPayoffDateToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :payoff_date, :string
  end
end
