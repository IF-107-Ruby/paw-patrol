require 'rails_helper'

feature 'employee visit unit dashboard' do
  let!(:company) { create(:company) }
  let!(:unit) { create(:unit, :with_employee_and_ticket, company: company) }
  let!(:employee_with_unit) { unit.users.first }

  before { login_as employee_with_unit }

  scenario 'successfully' do
    visit company_user_units_path
    expect(page).to have_css('h3', text: 'My units')
    expect(page).to have_text(unit.name)

    find_link(href: company_user_unit_path(unit.id)).click
    expect(page).to have_css('h3', text: 'Unit dashboard')
    expect(page).to have_text(unit.name)
  end
end
