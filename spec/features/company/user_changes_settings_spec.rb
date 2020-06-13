require 'rails_helper'

feature 'User changes settings' do
  let!(:company) { create(:company) }
  let!(:employee) { create(:employee, company: company) }
  let(:user_valid_params) { FactoryBot.attributes_for(:user) }
  let(:user_invalid_params) do
    { first_name: '', last_name: '', email: '', password: '' }
  end

  before do
    login_as employee
    visit company_settings_path
  end

  scenario 'successfully changes profile settings' do
    expect(page).to have_css('h3', text: 'Settings')
    fill_in 'user_settings_first_name', with: user_valid_params[:first_name]
    fill_in 'user_settings_last_name', with: user_valid_params[:last_name]
    fill_in 'user_settings_email', with: user_valid_params[:email]

    click_on 'Save Changes'

    expect(page).to have_selector('.notification.success.closeable',
                                  text: 'Settings updated!')
  end

  scenario 'successfully changes profile settings' do
    fill_in 'user_settings_first_name', with: user_invalid_params[:first_name]
    fill_in 'user_settings_last_name', with: user_invalid_params[:last_name]
    fill_in 'user_settings_email', with: user_invalid_params[:email]

    click_on 'Save Changes'

    expect(page).to have_css('.notification.warning.closeable',
                             text: 'Settings is not updated!')
    expect(page).to have_css('#error_explanation')
  end

  scenario 'successfully changes password' do
    expect(page).to have_css('h3', text: 'Password & Security')

    fill_in 'user_settings_password', with: user_valid_params[:password]
    fill_in 'user_settings_password_confirmation',
            with: user_valid_params[:password_confirmation]

    click_on 'Change password'

    expect(page).to have_selector('.notification.success.closeable',
                                  text: 'Settings updated!')
  end

  scenario 'unsuccessfully changes password' do
    fill_in 'user_settings_password', with: user_invalid_params[:password]
    fill_in 'user_settings_password_confirmation',
            with: user_invalid_params[:password]

    click_on 'Change password'

    expect(page).to have_css('.notification.warning.closeable',
                             text: 'Settings is not updated!')
    expect(page).to have_css('#error_explanation')
  end
end
