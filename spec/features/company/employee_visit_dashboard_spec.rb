require 'rails_helper'

feature 'employee visit dashboard' do
  include_context 'employee with ticket'

  before { login_as employee }

  scenario 'successfully' do
    visit company_dashboard_path
    expect(page).to have_text('Current tickets')
    expect(page).to have_text('Tickets history')

    expect(employee.current_tickets.count).to eq(1)
    expect(employee.resolved_tickets.count).to eq(1)
  end
end
