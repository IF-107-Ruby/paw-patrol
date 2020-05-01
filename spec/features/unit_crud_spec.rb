require 'rails_helper'

feature 'unit crud' do
  let!(:company) { create(:company) }
  let!(:company_owner) { create(:company_owner_relationship, company: company) }
  let!(:unit) { create(:unit, company: company) }

  before { login_as company_owner.user }

  scenario 'successful creating unit' do
    visit new_unit_path
    fill_in 'Unit name', with: 'Unit creation test'
    click_on 'Create Unit'

    expect(page).to have_text('Unit created successfully.')
    expect(page).to have_css('h2', text: 'Unit creation test')
  end

  scenario 'successful updating unit' do
    visit unit_path(unit)
    find('.edit-link').click
    fill_in 'Unit name', with: 'Unit updating test'
    click_on 'Save changes'

    expect(page).to have_text('Unit information updated.')
    expect(page).to have_css('h2', text: 'Unit updating test')
  end

  scenario 'successful deleting unit' do
    visit unit_path(unit)
    find('.delete-link').click

    expect(page).not_to have_content(unit.name)
  end
end
