FactoryBot.define do
  factory :company_registrations_form_params, class: CompanyRegistrationsForm do
    name { Faker::Internet.name }
    description { 'This company is created for test purposes.' }
    company_email { Faker::Internet.safe_email }
    sequence(:phone) { |n| "+38091#{n}11111" }

    first_name { Faker::Internet.name }
    last_name { Faker::Internet.name }
    user_email { Faker::Internet.safe_email }
    sequence(:password) { |n| "testpassword#{n}" }
    sequence(:password_confirmation) { |n| "testpassword#{n}" }
  end
end
