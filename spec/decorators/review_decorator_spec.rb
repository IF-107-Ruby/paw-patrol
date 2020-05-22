require 'rails_helper'

RSpec.describe ReviewDecorator do
  include_context 'employee with ticket'
  let!(:review) { create(:review, ticket: ticket).decorate }

  it 'month_of_reviewable' do
    expected_date = review.created_at.strftime('%B %Y')
    expect(review.month_of_reviewable).to eq(expected_date)
  end
end
