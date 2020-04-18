FactoryBot.define do
  factory :company do
    name { 'Test Company' }
    description { 'This company is created for test purposes.' }
    email { Faker::Internet.safe_email }
    sequence(:phone) { |n| "+38091#{n}11111" }
  end
end
