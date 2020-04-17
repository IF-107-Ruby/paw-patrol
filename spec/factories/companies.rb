FactoryBot.define do
  factory :unit do
    sequence(:name) { |n| "unit_#{n}" }
    qr_link { 'TEST_QR_LINK' }
    company
  end

  factory :company do
    name { 'Test Company' }
    description { 'This company is created for test purposes.' }
    sequence(:email) { |n| "company#{n}@example.com" }
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
