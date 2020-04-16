FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    is_admin { false }
    email { Faker::Internet.safe_email }
  end

  factory :admin, parent: :user do
    is_admin { true }
  end
end
