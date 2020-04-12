require 'rails_helper'

feature 'unit crud' do
  let!(:unit) { create(:unit) }

  scenario 'successful creating unit' do
    visit new_unit_path
    fill_in 'Name', with: 'Unit creation test'
    click_on 'Create Unit'

    expect(page).to have_text('Unit created successfully.')
    expect(page).to have_css('h1', text: 'Unit creation test')
  end

  scenario 'successful updating unit' do
    visit unit_path(unit)
    click_on 'Edit unit information'
    fill_in 'Name', with: 'Unit updating test'
    click_on 'Update information'

    expect(page).to have_text('Unit information updated.')
    expect(page).to have_css('h1', text: 'Unit updating test')
  end

  scenario 'successful deleting unit' do
    visit unit_path(unit)
    click_on 'Delete unit'

    expect(page).not_to have_content(unit.name)
  end
end