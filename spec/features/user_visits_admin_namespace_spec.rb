require 'rails_helper'

feature 'User visits admin namespace' do
  let(:user) { create(:user) }

  scenario 'unsuccessfully' do
    login_as user
    visit admin_dashboard_path
    expect(page.status_code).to eq(404)
    expect(page).to have_content('Routing Error')
  end
end
