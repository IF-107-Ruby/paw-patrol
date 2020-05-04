require 'rails_helper'

feature 'Admin redirected to admin root after login' do
  let(:admin) do
    create(:admin, password: 'password',
                   password_confirmation: 'password')
  end

  scenario 'successfully' do
    visit new_user_session_path
    fill_in id: 'user_email', with: admin.email
    fill_in id: 'user_password', with: 'password'
    find('button', class: 'button full-width button-sliding-icon ripple-effect').click

    expect(page).to have_text('Signed in successfully.')
    expect(page).to have_text("Howdy, #{admin.first_name}!")
  end
end
