require 'rails_helper'

feature 'Admin visits feedback\'s page' do
  before { @feedback = create(:feedback) }

  let(:admin) { create(:admin) }

  scenario 'successfully' do
    login_as(admin, scope: :user)
    visit admin_feedbacks_path
    expect(page).to have_text('Feedbacks')

    click_on 'Show'
    expect(page).to have_selector('section.feedback')
    expect(page).to have_selector('h2', text: "Author: #{@feedback.user_full_name}")
    expect(page).to have_selector('div.feedback-email', text: @feedback.email.to_s)
    expect(page).to have_selector('div.feedback-message', text: @feedback.message)
  end
end
