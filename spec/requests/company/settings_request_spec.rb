require 'rails_helper'

RSpec.describe 'Company::Settings', type: :request do
  let!(:user) { create(:user, :with_company) }

  describe 'GET /company/settings' do
    it 'returns http success' do
      login_as user
      get company_settings_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end
end
