require 'rails_helper'

feature 'User without company visits company namespace' do
  let(:user) { create(:user) }

  scenario 'unsuccessfully' do
    login_as user
    visit company_dashboard_path
    expect(page).to have_text('Manage your company with joy')
  end
end
