class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :budget_id
      t.string :access_token
      t.string :refresh_token
      t.string :last_login
      t.boolean :reminders?, default: true
      t.float :monthly_payment, default: 0

      t.timestamps
    end
  end
end
