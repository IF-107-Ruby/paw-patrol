require 'rails_helper'

feature 'Employee set ticket watchers', js: true do
  let!(:company) { create(:company) }
  let!(:unit) { create(:unit, :with_employees, company: company) }
  let!(:employee) { unit.employees.first }
  let!(:coworker) { unit.employees.second }
  let!(:ticket) { create(:ticket, :with_comments, user: employee, unit: unit) }

  before do
    login_as employee
    visit company_ticket_path(ticket)
  end

  scenario 'successfully set ticket watchers' do
    expect(page).to have_text('Add watchers')

    click_on 'Add watchers'
    wait_for_ajax

    find(".dropdown-toggle[data-id='ticket_watcher_ids']").click
    find('.inner.dropdown-menu li', text: coworker.decorate.full_name).click

    click_on 'Save changes'
    wait_for_ajax

    expect(ticket.watchers.reload).to include(coworker)
    expect(page).to have_text('Watchers updated')
  end
end
