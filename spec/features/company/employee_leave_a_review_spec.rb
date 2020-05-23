require 'rails_helper'

feature 'EmployeeLeaveAReview' do
  include_context 'employee with ticket'
  let(:review_attributes) { FactoryBot.attributes_for :review }

  before do
    login_as employee
    visit company_reviews_path
  end

  scenario 'successfully' do
    expect(page).to have_selector('h3', text: 'Reviews')
    expect(page).to have_selector('.company-not-rated', text: 'Not Rated')
    click_on 'Leave a Review'

    expect(page).to have_selector('h3', text: 'Leave a Review')
    choose('review_rating_3', option: '3')
    fill_in 'review_comment', with: review_attributes[:comment]
    within('.dashboard-content-inner') do
      click_on 'Leave a Review'
    end
    expect(page).to have_selector('.notification.success.closeable',
                                  text: 'Review saved!')
  end

  scenario 'unsuccessfully' do
    click_on 'Leave a Review'

    within('.dashboard-content-inner') do
      click_on 'Leave a Review'
    end

    expect(page).to have_css('.notification.warning.closeable',
                             text: 'Review is not saved!')
    expect(page).to have_css('#error_explanation')
  end
end
