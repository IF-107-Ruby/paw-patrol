FactoryBot.define do
  factory :unit do
    sequence(:name) { |n| "unit_#{n}" }
    sequence(:qr_link) { |n| "TEST_QR_LINK#{n}" }

    trait :with_parent do
      after(:build) do |o|
        o.parent = create(:unit)
        o.save
      end
    end

    trait :with_children do
      after(:build) do |o|
        o.save
        o.children.create(name: 'Child 1')
      end
    end
  end
end
