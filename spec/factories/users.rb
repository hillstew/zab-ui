FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "email@email.com" }
    access_token { 1 }
    refresh_token { 0 }
    last_login { "MyString" }
    reminders? { false }
    monthly_payment { 1.5 }
  end
end
