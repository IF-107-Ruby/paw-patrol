require 'rails_helper'

RSpec.describe 'Admin::Dashboards', type: :request do
  describe 'GET /index' do
    let(:admin) { create(:admin) }
    let(:user) { create(:user) }

    it 'returns http success if signed in as admin' do
      login_as admin
      get '/admin'
      expect(response).to have_http_status(:success)
    end

    it 'returns http success if signed in not as admin' do
      login_as user
      get '/admin'
      expect(response).to have_http_status(:not_found)
    end

    it 'returns http found if not signed in' do
      get '/admin'
      expect(response).to have_http_status(:found)
    end
  end
end
