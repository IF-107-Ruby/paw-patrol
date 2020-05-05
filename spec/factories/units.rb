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

    trait :with_users do
      after(:build) do |unit|
        unit.users = create_list :user, 5
      end
    end
    # factory :unit_with_users do
    #  transient do
    #    users_count { 5 }
    #  end
    #
    #  after(:create) do |unit, evaluator|
    #    create_list(:user, evaluator.users_count, units: [unit])
    #  end
    # end
  end
end
