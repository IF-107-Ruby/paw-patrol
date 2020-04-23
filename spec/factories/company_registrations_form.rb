FactoryBot.define do
  factory :company_registrations_form_params, class: CompanyRegistrationsForm do
    name { 'Test Company' }
    description { 'This company is created for test purposes.' }
    sequence(:company_email) { |n| "company#{n}@example.com" }
    sequence(:phone) { |n| "+38091#{n}11111" }

    first_name { 'Test' }
    last_name { 'User' }
    user_email { Faker::Internet.safe_email }
    sequence(:password) { |n| "testpassword#{n}" }
    sequence(:password_confirmation) { |n| "testpassword#{n}" }
  end
end
