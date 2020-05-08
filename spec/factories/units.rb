# == Schema Information
#
# Table name: units
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  qr_link    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint
#  ancestry   :string
#
FactoryBot.define do
  factory :unit do
    sequence(:name) { |n| "unit_#{n}" }
    sequence(:qr_link) { |n| "TEST_QR_LINK#{n}" }
    company

    trait :with_parent do
      after(:build) do |o|
        o.parent = create(:unit, company: o.company)
        o.save
      end
    end

    trait :with_children do
      after(:build) do |o|
        o.save
        o.children.create(name: 'Child 1', company: o.company)
      end
    end

    trait :with_employee do
      after(:build) do |unit|
        unit.users << build(:employee, company: unit.company)
      end
    end

    trait :with_employee_and_ticket do
      with_employee

      after(:create) do |unit|
        create(:ticket, user: unit.users.last, unit: unit)
      end
    end

    trait :with_employees do
      after(:build) do |unit|
        unit.users = build_list(:employee, 4, company: unit.company)
      end
    end

    trait :with_employees_and_tickets do
      with_employees

      after(:create) do |unit|
        unit.users.each do |user|
          create_list(:ticket, 5, user: user, unit: unit)
        end
      end
    end
  end
end
