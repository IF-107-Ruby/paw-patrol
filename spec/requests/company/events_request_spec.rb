require 'rails_helper'

RSpec.describe 'Company::Events', type: :request do
  let!(:company) { create(:company) }
  let!(:user) { create(:company_owner, company: company) }
  let!(:unit) { create(:unit, company: company) }
  let!(:event) { create(:event, unit: unit, user: user) }
  let(:event_params) { attributes_for(:event) }
  let(:params) { { event: event_params } }

  before { login_as user }

  describe 'GET /company/units/:unit_id/events' do
    it 'returns http success' do
      get company_unit_events_path(unit, format: :json)

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /company/units/:unit_id/events/:id.json' do
    it 'returns http success' do
      get company_unit_event_path(unit, event, format: :json)

      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /company/units/:unit_id/events.json' do
    it 'creates event with valid params' do
      before_count = Event.count
      post company_unit_events_path(unit, format: :json), params: params

      expect(Event.count).not_to eq(before_count)
      expect(response).to have_http_status(:created)
    end

    it 'does not create event with invalid params' do
      before_count = Event.count
      event_params[:title] = ''
      post company_unit_events_path(unit, format: :json), params: params

      expect(Event.count).to eq(before_count)
      expect(response).to render_template(:new)
    end
  end

  describe 'PATCH /company/units/:id.json' do
    it 'updates event if data is valid' do
      patch company_unit_event_path(unit, event, format: :json), params: params

      expect(Event.find(event.id).title)
        .to eq(event_params[:title])
      expect(response).to have_http_status(:success)
    end

    it 'does not update event with invalid params' do
      event_params[:title] = ''
      patch company_unit_event_path(unit, event, format: :json), params: params

      expect(Event.find(event.id).title)
        .not_to eq(event_params[:title])
    end
  end

  describe 'DELETE /company/units/:unit_id/events/:id.json' do
    it 'deletes unit and redirects to units page' do
      expect { delete company_unit_event_path(unit, event, format: :json) }
        .to change(Event, :count).by(-1)
    end
  end
end
