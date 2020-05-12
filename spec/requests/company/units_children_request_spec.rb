require 'rails_helper'

RSpec.describe 'Company::UnitsChildren', type: :request do
  let!(:company) { create(:company) }
  let!(:user) { create(:company_owner, company: company) }
  let!(:unit) { create(:unit, company: company) }

  before { login_as user }

  describe 'GET /company/units/:unit_id/children' do
    it 'returns http success' do
      get company_unit_children_path(unit), xhr: true

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end
end
