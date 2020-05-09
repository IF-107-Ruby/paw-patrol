require 'rails_helper'

RSpec.describe 'Company::RoomEmployees', type: :request do
  let!(:user) { create(:user, :with_company) }
  let(:unit) { create(:unit, :with_employees) }

  describe 'GET /index' do
    it 'returns http success' do
      login_as user
      get company_unit_room_employees_path(unit)
      expect(response).to have_http_status(:success)
    end
  end
end
