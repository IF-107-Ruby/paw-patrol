# == Schema Information
#
# Table name: telegram_profiles
#
#  id               :bigint           not null, primary key
#  first_name       :string
#  last_name        :string
#  username         :string
#  language_code    :string
#  user_id          :integer
#  connection_token :string
#  connected_at     :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :telegram_profile do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { Faker::Internet.username(specifier: 5..8) }
    language_code { 'en' }

    trait :with_user do
      user
      connected_at { Faker::Date.between(from: 2.days.ago, to: Time.zone.now) }
    end

    trait :with_connection_token do
      connection_token { Faker::Number.unique.number(digits: 6) }
    end
  end
end
