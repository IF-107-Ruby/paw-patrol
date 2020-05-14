require 'rails_helper'

feature 'User visits feedback\'s page' do
  before { @feedback = create(:feedback) }

  let(:user) { create(:user) }

  scenario 'unsuccessfully' do
    login_as(user, scope: :user)

    visit admin_feedbacks_path
    expect(page).not_to have_selector('section.feedbacks')
    expect(page).to have_css('.notification.warning.closeable',
                             text: 'You are not authorized to perform this action.')

    visit admin_feedback_path(@feedback)
    expect(page).not_to have_selector('section.feedback')
    expect(page).to have_css('.notification.warning.closeable',
                             text: 'You are not authorized to perform this action.')
  end
end
