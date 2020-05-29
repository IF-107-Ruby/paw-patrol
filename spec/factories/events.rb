# == Schema Information
#
# Table name: events
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  anchor     :datetime         not null
#  duration   :integer          default(1440), not null
#  frequency  :integer          default("once"), not null
#  color      :string(9)        default("#0000ff"), not null
#  ticket_id  :integer
#  user_id    :integer
#  unit_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :event do
    title { Faker::Lorem.sentence }
    anchor { Faker::Date.between(from: 1.year.ago, to: 1.year.from_now) }
    duration { Faker::Number.between(from: 1, to: 3) * 24 * 60 }
    frequency { :once }
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
