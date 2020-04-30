require 'rails_helper'

feature 'users' do
  let!(:company) { create(:company) }
  let!(:company_owner) { create(:company_owner_relationship, company: company) }

  before :each do
    login_as company_owner.user
  end

  scenario 'successfully create a user' do
    visit new_user_path
    fill_in 'First Name', with: 'Test'
    fill_in 'Last Name', with: 'User'
    fill_in 'Email', with: 'user@example.com'
    fill_in :user_password, with: 'testpassword'
    fill_in :user_password_confirmation, with: 'testpassword'
    choose('Employee')
    click_on 'Create new member'
    expect(page).to have_text('Company member created.')
    expect(page).to have_content('Test')
    expect(page).to have_content('User')
    expect(page).to have_content('Employee')
  end

  scenario 'successfully update a user' do
    visit user_path(company_owner.user)
    click_on 'Edit user profile'
    fill_in 'First Name', with: 'Updated First name'
    fill_in 'Last Name', with: 'Updated Last name'
    click_on 'Edit user'
    expect(page).to have_text('User profile updated')
    expect(page).to have_css('h2', text: 'Updated First name Updated Last name')
  end

  scenario 'successfully delete a user' do
    visit user_path(company_owner.user)
    click_on 'Delete user'
    expect(page).not_to have_content(company_owner.user.first_name)
    expect(page).not_to have_content(user.email)
  end
end
