require 'rails_helper'

feature 'user log in and log out' do
  include_context 'company with users'

  scenario 'successfuly' do
    visit new_user_session_path
    fill_in id: 'user_email', with: company_owner.email
    fill_in id: 'user_password', with: company_owner.password
    find('button', class: 'button full-width button-sliding-icon ripple-effect').click

    expect(page).to have_text('Profile')
    expect(page).to have_text('Sign out')

    expect(page).to have_text("Howdy, #{company_owner.first_name}!")

    click_on 'Logout'

    expect(page).to have_text('Signed out successfully.')
    expect(page).to have_text('Sign in')
  end
end
