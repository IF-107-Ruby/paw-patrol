require 'rails_helper'

RSpec.describe 'Company::TelegramProfiles', type: :request do
  include_context 'company with users'
  let!(:telegram_profile) { create(:telegram_profile, :with_connection_token) }

  before { login_as company_owner }

  describe 'GET /company/telegram_profile?telegram[connection_token]=:token' do
    context 'valid connection_token' do
      it 'sets user\'s telegram profile and redirects to settings' do
        expect(company_owner.telegram_profile).to be_nil

        get company_telegram_profile_path(
          telegram: { connection_token: telegram_profile.connection_token }
        )

        expect(response).to redirect_to(company_settings_path)

        company_owner.reload

        expect(company_owner.telegram_profile).to eq(telegram_profile)
      end
    end

    context 'invalid connection_token' do
      it 'doesn\'t set user\'s telegram profile and redirects to settings' do
        expect(company_owner.telegram_profile).to be_nil

        get company_telegram_profile_path(telegram: { connection_token: 'invalid' })

        expect(response).to redirect_to(company_settings_path)

        company_owner.reload
        expect(company_owner.telegram_profile).to be_nil
      end
    end
  end

  describe 'POST /company/telegram_profile' do
    context 'valid connection_token' do
      it 'sets user\'s telegram profile and redirects to settings' do
        expect(company_owner.telegram_profile).to be_nil

        post company_telegram_profile_path, params: {
          telegram: { connection_token: telegram_profile.connection_token }
        }

        expect(response).to redirect_to(company_settings_path)

        company_owner.reload

        expect(company_owner.telegram_profile).to eq(telegram_profile)
      end
    end

    context 'invalid connection_token' do
      it 'doesn\'t set user\'s telegram profile and redirects to settings' do
        expect(company_owner.telegram_profile).to be_nil

        post company_telegram_profile_path,
             params: { telegram: { connection_token: 'invalid' } }

        expect(response).to redirect_to(company_settings_path)

        company_owner.reload
        expect(company_owner.telegram_profile).to be_nil
      end
    end
  end

  describe 'DELETE /company/telegram_profile' do
    before do
      post company_telegram_profile_path, params: {
        telegram: { connection_token: telegram_profile.connection_token }
      }
      company_owner.reload
    end

    it 'removes user\'s telegram profile' do
      expect(company_owner.telegram_profile).to eq(telegram_profile)

      delete company_telegram_profile_path
      company_owner.reload

      expect(response).to redirect_to(company_settings_path)
      expect(company_owner.telegram_profile).to be_nil
    end
  end
end
