FactoryBot.define do
  factory :recurring_event do
    title { Faker::Lorem.sentence }
    anchor { Faker::Date.between(from: 10.days.ago, to: 10.days.from_now) }
    frequency { :weekly }
    color { Faker::Color.hex_color }
    unit
    user

    trait :weekly do
      frequency { :weekly }
    end
    trait :biweekly do
      frequency { :biweekly }
    end
    trait :monthly do
      frequency { :monthly }
    end
    trait :annually do
      frequency { :annually }
    end
  end
end
