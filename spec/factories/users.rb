FactoryBot.define do
  factory :user do
    first_name { 'Test' }
    last_name { 'User' }
    is_admin { false }
    email { Faker::Internet.safe_email }
    sequence(:password) { |n| "testpassword#{n}" }
    sequence(:password_confirmation) { |n| "testpassword#{n}" }
  end

  factory :admin, parent: :user do
    is_admin { true }
  end
end
