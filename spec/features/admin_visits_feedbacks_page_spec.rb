require 'rails_helper'

feature 'Admin visits feedback\'s page' do
  before { @feedback = create(:feedback) }

  let(:admin) { create(:admin) }

  scenario 'successfully' do
    login_as(admin, scope: :user)
    visit admin_feedbacks_path
    expect(page).to have_text('Feedbacks')
    expect(page).to have_selector('td', text: @feedback.user_full_name)
    expect(page).to have_selector('td', text: @feedback.email)
    expect(page).to have_selector('td', text: @feedback.message.truncate(50))
  end
end
