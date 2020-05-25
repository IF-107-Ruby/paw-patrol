require 'rails_helper'

RSpec.describe ReviewDecorator do
  include_context 'resolved_ticket_and_review'
  let!(:decorated_review) { review.decorate }

  it 'month_of_reviewable' do
    expected_date = review.created_at.strftime('%B %Y')
    expect(decorated_review.month_of_reviewable).to eq(expected_date)
  end
end
