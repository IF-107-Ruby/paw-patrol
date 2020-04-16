FactoryBot.define do
  factory :user do
    first_name { Faker::Internet.username(specifier: 3..50) }
    last_name { Faker::Internet.username(specifier: 3..50) }
    is_admin { false }
    sequence(:email) { |n| "user#{n}@example.com" }
  end

  factory :admin, parent: :user do
    is_admin { true }
  end
end
