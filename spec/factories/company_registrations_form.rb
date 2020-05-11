FactoryBot.define do
  factory :company_registrations_form_params, class: CompanyRegistrationsForm do
    name { Faker::Company.name }
    description { 'This company is created for test purposes.' }
    email { Faker::Internet.unique.safe_email }
    phone { Faker::PhoneNumber.cell_phone_in_e164 }

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    user_email { Faker::Internet.unique.safe_email }
    sequence(:password) { |n| "testpassword#{n}" }
    sequence(:password_confirmation) { |n| "testpassword#{n}" }
  end
end
