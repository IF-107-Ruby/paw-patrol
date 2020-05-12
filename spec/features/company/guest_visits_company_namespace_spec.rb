require 'rails_helper'

feature 'Guest visits company namespace' do
  scenario 'unsuccessfully' do
    visit company_dashboard_path
    expect(page).to have_css('h2', text: 'Log in')
    expect(page).to have_css('.notification.alert.closeable',
                             text: 'You need to sign in or sign up before continuing.')
  end
end
