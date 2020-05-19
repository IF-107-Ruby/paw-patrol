require 'rails_helper'

RSpec.describe Company::ReviewsHelper, type: :helper do
  include_context 'employee with ticket'

  let(:expected_not_rated) do
    '<span class="company-not-rated margin-bottom-5">Not Rated</span>'
  end
  let(:create_review_link) do
    '<a class="button ripple-effect margin-top-5 margin-bottom-10" ' \
    "href=\"/company/reviews/new?ticket_id=#{ticket.id}\">"\
    '<i class="icon-material-outline-thumb-up"> '\
    '</i> Leave a Review</a>'
  end

  it 'ticket reviewable status' do
    expect(helper.ticket_reviewable_status).to eq(expected_not_rated)
  end

  it 'review action link' do
    expect(helper.review_action_link(ticket)).to eq(create_review_link)
  end
end
