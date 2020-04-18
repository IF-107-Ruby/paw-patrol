FactoryBot.define do
  factory :user do
    first_name { Faker::Internet.username(specifier: 5..10) }
    last_name { Faker::Internet.username(specifier: 5..10) }
    is_admin { false }
    email { Faker::Internet.safe_email }
    sequence :password do |n|
      "TestPassword#{n}"
    end
    sequence :password_confirmation do |n|
      "TestPassword#{n}"
    end
  end

  factory :admin, parent: :user do
    is_admin { true }
  end

  factory :super_user, parent: :user do
    email { 'superuser@mail.com' }
    password { 'super_user_password' }
    password_confirmation { 'super_user_password' }
  end
end
