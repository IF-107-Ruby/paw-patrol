require 'rails_helper'

feature 'ticket creator create new following up ticket' do
  include_context 'unit with ticket and resolution'
  let!(:ticket) { create(:ticket, :with_resolution, unit: unit, user: unit.users.last) }

  before :each do
    ticket.resolved!
    login_as ticket.user
  end

  scenario 'successfully' do
    visit company_ticket_followed_path(ticket)

    expect(page).to have_text('Post a Ticket')
    expect(page).to have_text('Ticket Submission Form')
    expect(page).not_to have_selector('.btn-group.bootstrap-select.with-border')
    expect(page).to have_text('Ticket name')
    expect(page).to have_text('Describe your problem')

    click_on 'Post a Ticket'

    expect(page).to have_text(ticket.name.to_s)
    expect(page).to have_selector('.icon-material-outline-launch.ticket-icons')
  end
end
