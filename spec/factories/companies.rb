FactoryBot.define do
  factory :company do
    name { 'My Company' }
    description { 'About my company' }
    sequence(:email) { |n| "company#{n}@example.com" }
    phone { 'My phone' }
  end
end
