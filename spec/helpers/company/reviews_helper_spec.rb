require 'rails_helper'

RSpec.describe Company::ReviewsHelper, type: :helper do
  include_context 'employee with ticket'

  before do
    ticket.resolved!
  end

  let!(:decorated_ticket) { ticket.decorate }

  let(:not_rated_html) do
    '<span class="company-not-rated margin-bottom-5">Not Rated</span>'
  end

  context 'ticket is not reviewable' do
    it 'ticket reviewable status' do
      expect(helper.ticket_reviewable_status(decorated_ticket))
        .to eq(not_rated_html)
    end
  end

  context 'ticket is reviewable' do
    let!(:review) { create(:review, ticket: ticket) }

    it 'ticket reviewable status' do
      expect(helper.ticket_reviewable_status(decorated_ticket))
        .not_to eq(not_rated_html)
    end
  end
end
