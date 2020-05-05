require 'rails_helper'

RSpec.describe 'Company::Dashboards', type: :request do
  let(:user) { create(:user) }
  let(:user_with_company) { create(:user, :with_company) }

  it 'returns http success if signed in as user with company' do
    login_as user_with_company
    get '/company'
    expect(response).to have_http_status(:success)
  end

  it 'returns http not found if signed in as user without company' do
    login_as user
    get '/company'
    expect(response).to have_http_status(:not_found)
  end

  it 'returns http found if not signed in' do
    get '/company'
    expect(response).to have_http_status(:found)
  end
end
