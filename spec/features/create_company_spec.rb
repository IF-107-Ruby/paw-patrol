require 'rails_helper'

feature 'companies' do
  let!(:company) { create(:company) }

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
