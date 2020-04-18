require 'rails_helper'

feature 'companies' do
  let!(:company) { create(:company) }

  before :each do
    @current_user = FactoryBot.create :super_user
    visit new_user_session_path
    fill_in 'Email', with: @current_user.email
    fill_in 'Password', with: @current_user.password
    click_on 'Log in'
  end

  scenario 'successfully create a company' do
    visit new_company_path
    fill_in 'Company name', with: 'Test company'
    fill_in 'Description', with: 'About test company'
    fill_in 'Email', with: 'comp@example.com'
    fill_in 'Phone', with: '0991122333'
    click_on 'Create Company'
    expect(page).to have_text('Company has been created.')
    expect(page).to have_content('About test company')
    expect(page).to have_content('comp@example.com')
    expect(page).to have_content('0991122333')
    expect(page).to have_css('h2', text: 'Test company')
  end

  scenario 'successfully update a company' do
    visit company_path(company)
    find('.edit-link').click
    fill_in 'Company name', with: 'Updated company name'
    click_on 'Save changes'
    expect(page).to have_text('Company profile has been updated.')
    expect(page).to have_css('h2', text: 'Updated company name')
  end

  scenario 'successfully delete a company' do
    visit company_path(company)
    find('.delete-link').click
    expect(page).not_to have_content(company.name)
  end
end
