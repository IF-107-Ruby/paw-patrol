require 'rails_helper'

RSpec.describe Company::ReviewsHelper, type: :helper do
  include_context 'employee with ticket'
  let!(:decorated_ticket) { ticket.decorate }

  let(:not_rated_html) do
    '<span class="company-not-rated margin-bottom-5">Not Rated</span>'
  end

  context 'ticket is not reviewable' do
    let(:link_to_create_review_html) do
      '<a class="button ripple-effect margin-top-5 margin-bottom-10" ' \
    "href=\"/company/reviews/new?ticket_id=#{ticket.id}\">"\
    '<i class="icon-material-outline-thumb-up"> '\
    '</i> Leave a Review</a>'
    end

    it 'ticket reviewable status' do
      expect(helper.ticket_reviewable_status(ticket: decorated_ticket))
        .to eq(not_rated_html)
    end

    it 'review action link' do
      expect(helper.review_action_link(ticket: decorated_ticket))
        .to eq(link_to_create_review_html)
    end

    it 'create review link' do
      expect(helper.create_review_link(ticket_id: decorated_ticket.id))
        .to eq(link_to_create_review_html)
    end
  end

  context 'ticket is reviewable' do
    let!(:review) { create(:review, ticket: ticket) }

    let(:link_to_update_review_html) do
      '<a class="button gray ripple-effect margin-top-5 margin-bottom-10" '\
    "href=\"/company/reviews/#{review.id}/edit\">"\
    '<i class="icon-feather-edit"> '\
    '</i> Edit Review</a>'
    end

    it 'ticket reviewable status' do
      expect(helper.ticket_reviewable_status(ticket: decorated_ticket))
        .not_to eq(not_rated_html)
    end

    it 'review action link' do
      expect(helper.review_action_link(ticket: decorated_ticket))
        .to eq(link_to_update_review_html)
    end

    it 'update review link' do
      expect(helper.update_review_link(review: review)).to eq(link_to_update_review_html)
    end
  end
end
