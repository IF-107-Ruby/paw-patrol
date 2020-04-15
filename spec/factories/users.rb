FactoryBot.define do
  factory :user do
    first_name { 'Test' }
    last_name { 'User' }
    is_admin { 1 }
    sequence(:email) { |n| "user#{n}@example.com" }
  end
end
