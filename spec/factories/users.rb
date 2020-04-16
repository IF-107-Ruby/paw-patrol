FactoryBot.define do
  factory :user do
    first_name { 'Test' }
    last_name { 'User' }
    is_admin { false }
    sequence(:email) { |n| "user#{n}@example.com" }
  end

  factory :admin, parent: :user do
    is_admin { true }
  end
end
