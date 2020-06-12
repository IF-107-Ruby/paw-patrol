require 'rails_helper'

feature 'user connects telegram' do
  include_context 'company with users'
  let!(:telegram_profile) { create(:telegram_profile, :with_connection_token).decorate }

  before { login_as staff_member }

  scenario 'successfuly', js: true do
    visit company_settings_path

    within('#telegram') do
      fill_in id: 'telegram_connection_token', with: telegram_profile.connection_token
      click_on 'Connect account'
    end

    expect(page).to have_text('Account connected successfully!')

    within('#telegram') do
      expect(page).to have_text(telegram_profile.full_name)
      expect(page).to have_text(telegram_profile.username)

      find('li', text: telegram_profile.full_name, match: :first).hover
    end

    accept_confirm do
      find('i.icon-feather-trash-2', visible: false).click
    end

    expect(page).not_to have_text(telegram_profile.full_name)
    expect(page).not_to have_text(telegram_profile.username)

    expect(page).to have_text('Account disconnected successfully!')
  end

  scenario 'unsuccessfuly' do
    visit company_settings_path

    within('#telegram') do
      fill_in id: 'telegram_connection_token', with: 'invalid'
      find(class: 'button button-sliding-icon ripple-effect big', visible: false).click
    end

    expect(page).to have_text('Invalid connection token!')
  end
end
