class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.bigint :user_id
      t.string :ynab_id
      t.float :starting_total
      t.float :interest_rate, default: 0
      t.float :min_payment, default: 0
      t.boolean :paid_off?, default: false
      t.string :name
      t.float :balance

      t.timestamps
    end
  end
end
