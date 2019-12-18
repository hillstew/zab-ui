FactoryBot.define do
  factory :account do
    user_id { "" }
    ynab_id { "MyString" }
    starting_total { 1.5 }
    interest_rate { 1.5 }
    min_payment { 1.5 }
    paid_off? { false }
  end
end
