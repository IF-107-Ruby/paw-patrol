FactoryBot.define do
  factory :company do
    name { Faker::Internet.name }
    description { 'This company is created for test purposes.' }
    email { Faker::Internet.safe_email }
    sequence(:phone) { |n| "+38091#{n}11111" }

    factory :company_with_units do
      transient do
        units_count { 5 }
      end

      after(:create) do |company, evaluator|
        create_list(:unit, evaluator.units_count, company: company)
      end
    end
  end
end
