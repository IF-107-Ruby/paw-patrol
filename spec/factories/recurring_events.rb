# == Schema Information
#
# Table name: recurring_events
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  anchor     :datetime         not null
#  duration   :integer          default(1440), not null
#  frequency  :integer          default("weekly"), not null
#  color      :string(9)        default("#0000ff"), not null
#  ticket_id  :integer
#  user_id    :integer
#  unit_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
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
