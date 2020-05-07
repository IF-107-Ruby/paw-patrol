require 'rails_helper'

RSpec.describe 'Company::Companies', type: :request do
  describe 'GET /company' do
    let(:user_with_company) { create(:user, :with_company) }
    let(:user_without_company) { create(:user) }

    it 'returns http success if logged in and has company' do
      login_as user_with_company
      get '/company'
      expect(response).to have_http_status(:success)
    end

    it 'returns http not found if logged in and hasn\'t company' do
      login_as user_without_company
      get '/company'
      expect(response).to have_http_status(:not_found)
    end

    it 'returns http found if not signed in' do
      get '/company'
      expect(response).to have_http_status(:found)
    end
  end

  describe 'GET /company/edit' do
    let(:company) { create(:company) }

    let(:company_owner) { create(:company_owner, company: company) }
    let(:employee) { create(:employee, company: company) }

    it 'returns http success if company owner' do
      login_as company_owner
      get '/company/edit'
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH /company/edit' do
    let(:company_attributes) { attributes_for(:company) }

    let(:company_owner) { create(:company_owner, :with_company) }

    before { login_as company_owner }

    it 'updates company if data is valid' do
      patch '/company/edit', params: { company: company_attributes }

      expect(response).to redirect_to(company_path)
    end

    it 'doesn\'t update company if data is invalid' do
      company_attributes[:email] = 'invalid email'

      patch '/company/edit', params: { company: company_attributes }

      expect(response).not_to redirect_to(company_path)
      expect(response).to render_template(:edit)
    end
  end
end
