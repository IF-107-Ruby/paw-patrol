require 'rails_helper'

RSpec.describe Api::V1::TicketsController, type: :controller do
  include_context 'employee with ticket'

  xdescribe 'GET#index' do
    before do
      get :index, format: :json
    end

    context 'json response' do
      it 'returns http success' do
        expect(response).to render_template(:index)
        expect(response).to have_http_status(:success)
      end

      it 'returns json body response' do
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(%i[id name unit_id description])
      end
    end
  end
end
