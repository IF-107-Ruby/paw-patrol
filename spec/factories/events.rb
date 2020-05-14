FactoryBot.define do
  factory :event do
    title { Faker::Lorem.sentence }
    starts_at { Faker::Date.between(from: 20.days.ago, to: Time.zone.today) }
    ends_at { Faker::Date.between(from: Time.zone.today, to: 20.days.from_now) }
    color { Faker::Color.hex_color }
    user
    unit
  end
end
