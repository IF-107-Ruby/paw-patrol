require 'rails_helper'

feature 'companies' do
  let!(:company) { create(:company) }

  scenario 'successfully create a company' do
    visit new_company_path
    fill_in 'Company name', with: 'Test company'
    fill_in 'Description', with: 'About test company'
    fill_in 'Email', with: 'comp@example.com'
    fill_in 'Phone', with: '0991122333'
    click_on 'Create Company'
    expect(page).to have_text('Company created.')
    expect(page).to have_content('About test company')
    expect(page).to have_content('comp@example.com')
    expect(page).to have_content('0991122333')
    expect(page).to have_css('h2', text: 'Test company')
  end

  scenario 'successfully update a company' do
    visit company_path(company)
    click_on 'Edit company profile'
    fill_in 'Company name', with: 'Updated company name'
    click_on 'Save changes'
    expect(page).to have_text('Company profile updated.')
    expect(page).to have_css('h2', text: 'Updated company name')
  end

  scenario 'successfully delete a company' do
    visit company_path(company)
    click_on 'Delete company'
    expect(page).not_to have_content(company.name)
  end
end
