require 'rails_helper'

feature 'Admin visits admin namespace' do
  let(:admin) { create(:admin) }

  scenario 'successfully' do
    login_as admin
    visit admin_dashboard_path
    expect(page.status_code).to eq(200)
    expect(page).to have_text("Howdy, #{admin.first_name}!")
  end
end
