require 'rails_helper'

RSpec.describe 'RoomEmployees', type: :request do
  let(:unit) { create(:unit, :with_users) }
  describe 'GET /index' do
    it 'returns http success' do
      get unit_room_employees_path(unit)
      expect(response).to have_http_status(:success)
    end
  end
end
