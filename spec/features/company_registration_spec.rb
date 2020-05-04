require 'rails_helper'

feature 'company registration' do
  let(:company_registration) { create :company_registrations_form_params }

  scenario 'successfuly registrate company, log in and log out' do
    visit sign_up_path
    fill_in id: 'company_registrations_form_company_name',
            with: company_registration.company_name
    fill_in id: 'company_registrations_form_description',
            with: company_registration.description
    fill_in id: 'company_registrations_form_company_email',
            with: 'companyemail@company.com'
    fill_in id: 'phone',
            with: company_registration.phone
    fill_in id: 'company_registrations_form_first_name',
            with: company_registration.first_name
    fill_in id: 'company_registrations_form_last_name',
            with: company_registration.last_name
    fill_in id: 'company_registrations_form_user_email',
            with: 'companyuseremail@company.com'
    fill_in id: 'company_registrations_form_password',
            with: company_registration.password
    fill_in id: 'company_registrations_form_password_confirmation',
            with: company_registration.password
    click_on 'Create Company'

    expect(page).to have_text('Company has been created.')

    visit new_user_session_path
    fill_in id: 'user_email', with: 'companyuseremail@company.com'
    fill_in id: 'user_password', with: company_registration.password
    find('button', class: 'button full-width button-sliding-icon ripple-effect').click

    expect(page).to have_text('Signed in successfully.')
    expect(page).to have_text('Profile')
    expect(page).to have_text('Sign out')

    within('#footer') do
      click_on 'Sign out'
    end
    expect(page).to have_text('Signed out successfully.')
    expect(page).to have_text('Sign in')
  end
end
