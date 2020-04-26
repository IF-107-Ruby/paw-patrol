FactoryBot.define do
  factory :ticket do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    user { create(:user) }
  end
end
