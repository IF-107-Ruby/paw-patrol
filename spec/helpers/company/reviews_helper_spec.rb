require 'rails_helper'

RSpec.describe Company::ReviewsHelper, type: :helper do
  include_context 'employee with ticket'
  let!(:decorated_ticket) { ticket.decorate }

  let(:expected_not_rated) do
    '<span class="company-not-rated margin-bottom-5">Not Rated</span>'
  end

  let(:link_to_create_review) do
    '<a class="button ripple-effect margin-top-5 margin-bottom-10" ' \
    "href=\"/company/reviews/new?ticket_id=#{ticket.id}\">"\
    '<i class="icon-material-outline-thumb-up"> '\
    '</i> Leave a Review</a>'
  end

  context 'ticket is not reviewable' do
    it 'ticket reviewable status' do
      expect(helper.ticket_reviewable_status(ticket: decorated_ticket))
        .to eq(expected_not_rated)
    end

    it 'review action link' do
      expect(helper.review_action_link(ticket: decorated_ticket))
        .to eq(link_to_create_review)
    end
  end

  context 'ticket is reviewable' do
    before do
      create(:review, ticket: ticket)
    end

    it 'ticket reviewable status' do
      expect(helper.ticket_reviewable_status(ticket: decorated_ticket))
        .not_to eq(expected_not_rated)
    end

    it 'review action link' do
      expect(helper.review_action_link(ticket: decorated_ticket))
        .not_to eq(link_to_create_review)
    end
  end
end
