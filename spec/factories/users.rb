FactoryBot.define do
  factory :user do
    first_name { Faker::Internet.username(specifier: 3..50) }
    last_name { Faker::Internet.username(specifier: 3..50) }
    is_admin { false }
    email { Faker::Internet.safe_email }
  end

  factory :admin, parent: :user do
    is_admin { true }
  end
end
