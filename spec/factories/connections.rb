FactoryBot.define do
  factory :connection do
    user_id { "" }
    accepted? { false }
    connected_user_id { "" }
  end
end
