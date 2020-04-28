require 'rails_helper'

feature 'company registration' do
  let(:company_registration) { create :company_registrations_form_params }

  scenario 'successfuly registrate company, log in and log out' do
    visit new_company_path
    fill_in 'Company name', with: 'Name'
    fill_in 'Description', with: 'Desc'
    fill_in 'Company email', with: 'companyemail@company.com'
    fill_in 'Phone', with: '+38091934561'
    fill_in 'First Name', with: 'First Name'
    fill_in 'Last Name', with: 'Last name'
    fill_in 'User email', with: 'companyuseremail@company.com'
    fill_in 'company_registrations_form_password', with: 'passwordtext'
    fill_in 'company_registrations_form_password_confirmation',
            with: 'passwordtext'
    click_on 'Create Company'

    expect(page).to have_text('Company has been created.')

    visit new_user_session_path
    fill_in 'Email', with: 'companyuseremail@company.com'
    fill_in 'Password', with: 'passwordtext'
    find('input', class: 'btn btn btn-primary').click

    expect(page).to have_text('Signed in successfully.')
    expect(page).to have_text('Profile')
    expect(page).to have_text('Sign out')

    click_on 'Sign out'
    expect(page).to have_text('Signed out successfully.')
    expect(page).to have_text('Sign in')
  end
end
