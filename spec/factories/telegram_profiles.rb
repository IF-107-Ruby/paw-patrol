FactoryBot.define do
  factory :telegram_profile do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { Faker::Internet.username(specifier: 5..8) }
    language_code { 'en' }

    trait :with_user do
      user
      linked_at { Faker::Date.between(from: 2.days.ago, to: Time.zone.now) }
    end

    trait :with_connection_token do
      link_token { Faker::Number.unique.number(digits: 6) }
    end
  end
end
