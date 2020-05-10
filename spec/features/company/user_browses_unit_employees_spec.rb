require 'rails_helper'

feature 'user browses unit employees' do
  let!(:company) { create(:company) }
  let!(:company_owner) { create(:company_owner, company: company) }
  let!(:unit) { create(:unit, :with_parent, :with_employees, company: company) }

  before { login_as company_owner }

  scenario 'successfully', js: true do
    visit company_units_path
    expect(page).to have_text("#{company.name}'s units")
    expect(page).to have_text('Company units')

    expect(page).not_to have_text(unit.name)
    find_link(href: company_unit_children_path(unit.parent.id)).click
    wait_for_ajax
    expect(page).to have_text(unit.name)

    click_on unit.name
    find_link(href: company_unit_room_employees_path(unit.id)).click
    expect(page).to have_text(unit.users.first.first_name)
  end
end
