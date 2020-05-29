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
    description { Faker::Lorem.paragraph_by_chars }
    email { Faker::Internet.unique.safe_email }
    phone { Faker::PhoneNumber.cell_phone_in_e164 }
  end

  factory :company_with_units, parent: :company do
    transient do
      units_count { 5 }
    end

    after(:create) do |company, evaluator|
      create_list(:unit, evaluator.units_count, company: company)
    end
  end
end
