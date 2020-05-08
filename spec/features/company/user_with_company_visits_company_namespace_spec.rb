require 'rails_helper'

feature 'User with company visits company namespace' do
  let(:user) { create(:user, :with_company) }

  scenario 'successfully' do
    login_as user
    visit company_dashboard_path
    expect(page.status_code).to eq(200)
    expect(page).to have_text("Howdy, #{user.first_name}!")
  end
end
