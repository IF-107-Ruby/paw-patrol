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
        o.parent = create(:unit)
        o.save
      end
    end

    trait :with_children do
      after(:build) do |o|
        o.save
        o.children.create(name: 'Child 1', company: o.company)
      end
    end
  end
end
