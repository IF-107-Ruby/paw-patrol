require 'rails_helper'

RSpec.describe 'Company::AccessTokens', type: :request do
  let!(:user) { create(:user, :with_company) }
  let!(:user_with_token) { create(:user, :with_company, :with_access_token) }

  describe 'POST /company/access_token' do
    before { login_as user }

    it 'returns http success' do
      expect(user.access_token).to be_nil

      post '/company/access_token'
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(company_settings_path)
      user.reload
      expect(user.access_token).not_to be_nil
    end
  end

  describe 'PATCH /company/access_token' do
    before { login_as user_with_token }

    it 'returns http success' do
      expect(user_with_token.access_token_enabled).to be true

      patch '/company/access_token',
            params: { user: { access_token_enabled: false } }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(company_settings_path)
      user_with_token.reload
      expect(user_with_token.access_token).not_to be true
    end
  end

  describe 'DELETE /company/access_token' do
    before { login_as user_with_token }

    it 'returns http success' do
      expect(user_with_token.access_token).not_to be_nil

      delete '/company/access_token'
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(company_settings_path)

      user_with_token.reload
      expect(user_with_token.access_token).to be_nil
    end
  end
end
