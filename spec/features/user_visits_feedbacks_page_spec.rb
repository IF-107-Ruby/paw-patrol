require 'rails_helper'

feature 'User visits feedback\'s page' do
  let(:user) { create(:user) }
  let(:feedback) { create(:feedback) }

  before { login_as user }

  scenario 'unsuccessfully visit feedbacks_path' do
    visit admin_feedbacks_path
    expect(page.status_code).to eq(404)
    expect(page).to have_content('Routing Error')
  end

  scenario 'unsuccessfully visit feedback_path' do
    visit admin_feedback_path(feedback)
    expect(page.status_code).to eq(404)
    expect(page).to have_content('Routing Error')
  end
end
