require 'rails_helper'

feature 'EmployeeUpdateAReview' do
  include_context 'resolved_ticket_and_review'
  let(:review_attributes) { FactoryBot.attributes_for :review }

  before do
    login_as employee
    visit company_reviews_path
  end

  scenario 'successfully' do
    expect(page).to have_selector('h3', text: 'Reviews')
    expect(page).to have_selector('.item-details')
    click_on 'Edit Review'

    expect(page).to have_selector('h3', text: 'Change Review')
    choose('review_rating_3', option: '3')
    fill_in 'review_comment', with: review_attributes[:comment]
    within('.dashboard-content-inner') do
      click_on 'Save Changes'
    end
    expect(page).to have_selector('.notification.success.closeable',
                                  text: 'Review updated!')
  end
end
