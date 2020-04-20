require 'rails_helper'

feature 'user registration and login' do
  let!(:user) { create :super_user }

  before :each do
    user.email = 'testuseremail@mail.com'
    user.password = 'password'
  end

  scenario 'successful user registration, log out and login' do
    visit new_user_registration_path
    fill_in 'First Name', with: user.first_name
    fill_in 'Last Name', with: user.last_name
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password
    find('input', class: 'btn btn-primary').click

    expect(page).to have_text('You have signed up successfully')
    expect(page).to have_text('Create company')
    expect(page).to have_text('Sign out')

    click_on 'Sign out'
    expect(page).to have_text('Signed out successfully.')
    expect(page).to have_text('Sign in')
    expect(page).to have_text('Sign up')

    click_on 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    find('input', class: 'btn btn-primary').click

    expect(page).to have_text('Signed in successfully.')
    expect(page).to have_text('Create company')
    expect(page).to have_text('Sign out')
  end
end