require 'rails_helper'

feature 'Guest visits admin namespace' do
  scenario 'unsuccessfully' do
    visit admin_dashboard_path
    expect(page).to have_css('h2', text: 'Log in')
    expect(page).to have_css('.alert.alert-alert.mt-2',
                             text: 'You need to sign in or sign up before continuing.')
  end
end
