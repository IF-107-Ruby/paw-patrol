RSpec.shared_context 'resolved_ticket_and_review' do
  include_context 'employee with ticket'

  before do
    ticket.resolved!
  end

  let!(:review) { create(:review, ticket: ticket) }
end
