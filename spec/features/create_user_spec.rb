require 'rails_helper'

feature 'users' do
  let!(:user) { create(:user) }

  scenario 'successfully create a user' do
    visit new_user_path
    fill_in 'First Name', with: 'Test'
    fill_in 'Last Name', with: 'User'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_on 'Create new user'
    expect(page).to have_text('You have signed up successfully')
  end

  scenario 'successfully update a user' do
    visit user_path(user)
    click_on 'Edit user profile'
    fill_in 'First Name', with: 'Updated First name'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_on 'Edit user'
    expect(page).to have_text('User profile updated')
    expect(page).to have_css('h1', text: 'Updated First name')
  end

  scenario 'successfully delete a user' do
    visit user_path(user)
    click_on 'Delete user'
    expect(page).not_to have_content(user.first_name)
  end
end
