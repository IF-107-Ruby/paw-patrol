require 'rails_helper'

feature 'Company owner add room employees' do
  let!(:company) { create(:company) }
  let!(:company_owner) { create(:company_owner, company: company) }
  let!(:employee) { create(:employee, company: company) }
  let!(:unit) { create(:unit, company: company) }

  before { login_as company_owner }

  scenario 'successfully' do
    visit company_unit_room_employees_path(unit)
    find_link(href: edit_company_unit_room_employees_path(unit)).click

    expect(page).to have_text('Add room employees')

    find(:select, 'unit_user_ids')
      .first(:option, employee.decorate.full_name)
      .select_option

    find('button', class: 'button ripple-effect button-sliding-icon').click

    expect(page).to have_text('Employees updated!')
    expect(page).to have_text(employee.decorate.full_name)
  end
end
