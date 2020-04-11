FactoryBot.define do
  factory :company do
    name { 'Test Company' }
    description { 'This company is created for test purposes.' }
    sequence(:email) { |n| "company#{n}@example.com"}
    sequence(:phone) { |n| "+38091#{n}11111"}
  end
end
