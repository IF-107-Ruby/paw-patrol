require 'rails_helper'

feature 'company registration' do
  let(:company_registration) { create :company_registrations_form_params }

  scenario 'successfuly registrate company, log in and log out' do
    visit new_company_path
    fill_in 'Company name', with: company_registration.company_name
    fill_in 'Description', with: company_registration.description
    fill_in 'Company email', with: 'companyemail@company.com'
    fill_in 'Phone', with: company_registration.phone
    fill_in 'First Name', with: company_registration.first_name
    fill_in 'Last Name', with: company_registration.last_name
    fill_in 'User email', with: 'companyuseremail@company.com'
    fill_in 'company_registrations_form_password', with: company_registration.password
    fill_in 'company_registrations_form_password_confirmation',
            with: company_registration.password
    click_on 'Create Company'

    expect(page).to have_text('Company has been created.')

    visit new_user_session_path
    fill_in 'Email', with: 'companyuseremail@company.com'
    fill_in 'Password', with: company_registration.password
    find('input', class: 'btn btn btn-primary').click

    expect(page).to have_text('Signed in successfully.')
    expect(page).to have_text('Profile')
    expect(page).to have_text('Sign out')

    click_on 'Sign out'
    expect(page).to have_text('Signed out successfully.')
    expect(page).to have_text('Sign in')
  end
end
