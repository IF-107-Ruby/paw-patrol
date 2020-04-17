require 'rails_helper'

feature 'unit crud' do
  let!(:unit) { create(:unit) }

  scenario 'successful creating unit' do
    visit new_company_unit_path(unit.company)
    fill_in 'Unit name', with: 'Unit creation test'
    click_on 'Create Unit'

    expect(page).to have_text('Unit created successfully.')
    expect(page).to have_css('h2', text: 'Unit creation test')
  end

  scenario 'successful updating unit' do
    visit company_unit_path(unit.company, unit)
    click_on 'Edit unit information'
    fill_in 'Unit name', with: 'Unit updating test'
    click_on 'Save changes'

    expect(page).to have_text('Unit information updated.')
    expect(page).to have_css('h2', text: 'Unit updating test')
  end

  scenario 'successful deleting unit' do
    visit company_unit_path(unit.company, unit)
    click_on 'Delete unit'

    expect(page).not_to have_content(unit.name)
  end
end
