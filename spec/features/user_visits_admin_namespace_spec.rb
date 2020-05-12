require 'rails_helper'

feature 'User visits admin namespace' do
  let(:user) { create(:user) }

  scenario 'unsuccessfully' do
    login_as user
    visit admin_dashboard_path
    expect(page).not_to have_text("Howdy, #{user.first_name}!")
    expect(page).to have_css('.notification.warning.closeable',
                             text: 'You are not authorized to perform this action.')
  end
end
