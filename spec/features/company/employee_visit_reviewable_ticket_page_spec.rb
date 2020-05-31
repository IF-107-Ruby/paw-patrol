require 'rails_helper'

feature 'EmployeeVisitReviewableTicketPage' do
  include_context 'resolved_ticket_and_review'

  before do
    login_as employee
    visit company_ticket_path(ticket)
  end
  scenario 'successfully' do
    expect(page).to have_selector('h3', text: 'Ticket Completion')
    expect(page).to have_selector('.ticket-completion__review')
    expect(page).to have_selector(".star-rating[data-rating=\"#{review.rating}\"]")
    expect(page).to have_selector('.icon-material-outline-date-range',
                                  text: review.created_at.strftime('%B %Y'))

    click_on 'Show more ...'

    expect(page).to have_selector('h3', text: 'Review')
    expect(page).to have_selector('.review-comment')
  end
end
