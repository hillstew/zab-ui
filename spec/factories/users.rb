FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "email@email.com" }
    budget_id { 1 }
    token { 1 }
    last_login { "MyString" }
    reminders? { false }
    monthly_payment { 1.5 }
  end
end
