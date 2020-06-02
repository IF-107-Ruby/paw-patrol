require 'rails_helper'

RSpec.describe 'Company::Users', type: :request do
  include_context 'company with users'

  before { login_as company_owner }

  describe 'GET /company/users' do
    it 'returns http success' do
      get company_users_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /company/users/:id' do
    it 'returns http success' do
      get company_user_path(employee)

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET /company/users/new' do
    it 'returns http success' do
      get new_company_user_path

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /company/users/' do
    let(:user_params) { attributes_for(:staff_member) }

    it 'creates user with valid params' do
      post company_users_path, params: { user: user_params }

      expect(response).to redirect_to(company_user_path(User.last))
    end

    it 'doest\'t create user with invalid params' do
      user_params[:email] = 'invalid email'
      post company_users_path, params: { user: user_params }

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end

  describe 'GET /company/users/:id/edit' do
    it 'returns http success' do
      get edit_company_user_path(employee)

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH /company/users/:id' do
    let(:user_params) { attributes_for(:staff_member) }

    it 'updates user if data is valid' do
      patch company_user_path(employee), params: { user: user_params }

      expect(response).to redirect_to(company_user_path(employee))
    end

    it 'doest\'t update user if data is invalid' do
      user_params[:email] = 'invalid email'
      patch company_user_path(employee), params: { user: user_params }

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:edit)
    end
  end

  describe 'DELETE /company/users/:id' do
    it 'deletes user and redirects to users page' do
      delete company_user_path(employee)

      expect(response).to redirect_to(company_users_path)
    end
  end
end
