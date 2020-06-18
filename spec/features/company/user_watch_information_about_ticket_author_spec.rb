require 'rails_helper'

feature 'User watch information about ticket author' do
  include_context 'employee with ticket'

  let(:ticket_author) { employee.decorate }
  let!(:user) { create(:staff_member, company: company) }

  before do
    login_as user
    visit company_ticket_path(ticket)
  end

  scenario 'successfully' do
    expect(page).to have_selector('h3', text: 'Author')
    expect(page).to have_selector('h3', text: ticket_author.full_name)
    expect(page).to have_selector('span', text: ticket_author.display_role)

    click_on 'Show more'

    expect(page).to have_selector('h3', text: 'View copmany member')
    expect(page).to have_selector('h3', text: ticket_author.full_name)
    expect(page).to have_selector('span', text: ticket_author.display_role)
    expect(page).to have_selector('a', text: ticket_author.email)
    expect(page).to have_selector('a[href="#user_tickets"]',
                                  text: "Create#{ticket_author.created_tickets_count}")
    expect(page).to have_selector('h3', text: 'Tickets created by the user')
    expect(page).to have_selector('a', text: ticket.name)
  end
end
