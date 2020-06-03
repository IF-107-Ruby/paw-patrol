require 'rails_helper'

feature 'employee visit dashboard' do
  include_context 'company with users'

  before { login_as company_owner }

  scenario 'successfully', js: true do
    visit company_dashboard_path

    expect(page).to have_text('Workers')
    expect(page).to have_text('Responsible users')
  end
end
