require 'rails_helper'

RSpec.describe Api::V1::TicketsController, type: :controller do
  render_views

  include_context 'employee with ticket'

  describe 'GET#index' do
    before do
      request.headers['Authorization'] = "Bearer #{access_token}"
      get :index, format: :json
    end

    context 'json response' do
      it 'returns http success and renders index template' do
        expect(response).to render_template(:index)
        expect(response).to have_http_status(:success)
        
        json_response = JSON.parse(response.body)
        expect(json_response.size).to eq(1)
        expect(json_response.first.keys)
          .to match_array(%w[id name unit_id description user_id])
      end
    end
  end
end
