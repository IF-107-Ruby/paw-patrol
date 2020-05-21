require 'rails_helper'

feature 'EmployeePostATicket' do
  let!(:company) { create(:company) }
  let!(:unit) { create(:unit, :with_employees, company: company) }
  let!(:employee) { unit.employees.first }
  let!(:coworker) { unit.employees.second }
  let!(:ticket) { create(:ticket, :with_comments, user: employee, unit: unit) }

  before do
    login_as employee
    visit company_ticket_path(ticket)
  end

  scenario 'successfully' do
    expect(page).to have_text('Add watchers')
    expect(ticket.watchers).to include(employee)

    click_on 'Add watchers'
    find(:select, 'ticket_watcher_ids')
      .first(:option, coworker.decorate.full_name)
      .select_option
    click_on 'Save changes'

    expect(ticket.watchers.reload).to include(coworker)
  end
end
