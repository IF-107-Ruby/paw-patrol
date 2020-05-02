require 'rails_helper'

feature 'User visit feedback\'s page' do
  before { @feedback = create(:feedback) }

  let(:admin) { create(:admin) }
  let(:user) { create(:user) }

  scenario 'successfully' do
    login_as(admin, scope: :user)
    visit admin_feedbacks_path
    expect(page).to have_selector('section.feedbacks')

    click_on 'Show'
    expect(page).to have_selector('section.feedback')
    expect(page).to have_selector('h2', text: "Message from #{@feedback.user_full_name}")
    expect(page).to have_selector('div.feedback-email', text: "Email:#{@feedback.email}")
    expect(page).to have_selector('div.feedback-message', text: @feedback.message)
    expect(page).to have_selector('a', text: 'Delete')
  end

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
