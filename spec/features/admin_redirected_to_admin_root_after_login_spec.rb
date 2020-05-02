require 'rails_helper'

feature 'Admin redirected to admin root after login' do
  let(:admin) do
    create(:admin, password: 'password',
                   password_confirmation: 'password')
  end

  scenario 'successfully' do
    visit new_user_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: 'password'
    find('input', class: 'btn btn btn-primary').click

    expect(page).to have_text('Signed in successfully.')
    expect(page).to have_text("Howdy, #{admin.first_name}!")
  end
end
