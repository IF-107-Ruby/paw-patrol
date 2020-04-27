# == Schema Information
#
# Table name: companies
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :text
#  email       :string           not null
#  phone       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
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
