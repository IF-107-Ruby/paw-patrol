require 'rails_helper'

RSpec.describe 'Company::UserUnits', type: :request do
  let!(:company) { create(:company) }
  let!(:unit) { create(:unit, :with_employee_and_ticket, company: company) }
  let!(:employee) { unit.users.first }

  before { login_as employee }

  describe 'GET /company/user_units' do
    it 'returns http success' do
      get company_user_units_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /company/user_units/:id' do
    it 'returns http success' do
      get company_user_unit_path(unit)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end
end
