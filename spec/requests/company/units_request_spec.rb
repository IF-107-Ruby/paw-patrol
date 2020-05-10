require 'rails_helper'

RSpec.describe 'Company::Units', type: :request do
  let!(:company) { create(:company) }
  let!(:user) { create(:company_owner, company: company) }
  let!(:unit) { create(:unit, company: company) }

  before { login_as user }

  describe 'GET /company/units' do
    it 'returns http success' do
      get company_units_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /company/units/:id' do
    it 'returns http success' do
      get company_unit_path(unit)

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET /company/units/new' do
    it 'returns http success' do
      get new_company_unit_path

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /company/units/' do
    let(:unit_params) { attributes_for(:unit) }

    it 'creates unit with valid params' do
      post company_units_path, params: { unit: unit_params }

      expect(response).to redirect_to(company_unit_path(Unit.last))
    end

    it 'doest\'t creates unit with invalid params' do
      unit_params[:name] = ''
      post company_units_path, params: { unit: unit_params }

      expect(response).to render_template(:new)
    end
  end

  describe 'GET /company/units/:id/edit' do
    it 'returns http success' do
      get edit_company_unit_path(unit)

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH /company/units/:id' do
    let(:unit_params) { attributes_for(:unit) }

    it 'updates unit if data is valid' do
      patch company_unit_path(unit), params: { unit: unit_params }

      expect(response).to redirect_to(company_unit_path(unit))
    end

    it 'doest\'t updates unit if data is invalid' do
      unit_params[:name] = ''
      patch company_unit_path(unit), params: { unit: unit_params }

      expect(response).to render_template(:edit)
    end
  end

  describe 'DELETE /company/units/:id' do
    it 'deletes unit and redirects to units page' do
      delete company_unit_path(unit)

      expect(response).to redirect_to(company_units_path)
    end
  end
end
