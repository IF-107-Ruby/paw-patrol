require 'rails_helper'

RSpec.describe 'RoomEmployees', type: :request do
  let(:users_units_relationship) { create(:users_units_relationship) }
  describe 'GET /index' do
    it 'returns http success' do
      get unit_room_employees_path(users_units_relationship.unit)
      expect(response).to have_http_status(:success)
    end
  end
end
