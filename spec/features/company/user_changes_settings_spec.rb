require 'rails_helper'

feature 'User changes settings' do
  let(:user_password) { '123456' }
  let!(:company) { create(:company) }
  let!(:employee) do
    create(:employee,
           password: user_password,
           password_confirmation: user_password,
           company: company)
  end
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
    attach_file 'user_settings_avatar', "#{Rails.root}/spec/files/avatars/0.jpg"
    fill_in 'user_settings_first_name', with: user_valid_params[:first_name]
    fill_in 'user_settings_last_name', with: user_valid_params[:last_name]
    fill_in 'user_settings_email', with: user_valid_params[:email]

    click_on 'Save Changes'

    expect(page).to have_selector('.notification.success.closeable',
                                  text: 'Account settings updated!')
  end

  scenario 'unsuccessfully changes profile settings' do
    fill_in 'user_settings_first_name', with: user_invalid_params[:first_name]
    fill_in 'user_settings_last_name', with: user_invalid_params[:last_name]
    fill_in 'user_settings_email', with: user_invalid_params[:email]

    click_on 'Save Changes'

    expect(page).to have_css('.notification.warning.closeable',
                             text: 'Account settings is not updated!')
    expect(page).to have_css('#error_explanation')
  end

  scenario 'successfully changes password' do
    expect(page).to have_css('h3', text: 'Password & Security')

    fill_in 'user_password_settings_current_password', with: user_password
    fill_in 'user_password_settings_password', with: user_valid_params[:password]
    fill_in 'user_password_settings_password_confirmation',
            with: user_valid_params[:password_confirmation]

    click_on 'Change password'

    expect(page).to have_selector('.notification.success.closeable',
                                  text: 'Password settings updated!')
  end

  scenario 'unsuccessfully changes password' do
    fill_in 'user_password_settings_current_password', with: 'asdasdsad'
    fill_in 'user_password_settings_password', with: user_invalid_params[:password]
    fill_in 'user_password_settings_password_confirmation',
            with: user_invalid_params[:password_confirmation]

    click_on 'Change password'

    expect(page).to have_css('.notification.warning.closeable',
                             text: 'Password settings is not updated!')
    expect(page).to have_css('#error_explanation')
  end
end
