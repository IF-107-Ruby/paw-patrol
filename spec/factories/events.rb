# == Schema Information
#
# Table name: events
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  starts_at  :datetime         not null
#  ends_at    :datetime         not null
#  color      :string           default("#0000ff"), not null
#  ticket_id  :integer
#  user_id    :integer
#  unit_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
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
