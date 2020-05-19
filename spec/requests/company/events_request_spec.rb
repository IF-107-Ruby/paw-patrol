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

  describe 'GET /company/units/:unit_id/events/:id' do
    it 'returns http success' do
      get company_unit_event_path(unit, event), xhr: true

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET /company/units/:unit_id/events/new' do
    it 'returns http success' do
      get new_company_unit_event_path(unit), xhr: true

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /company/units/:unit_id/events' do
    it 'creates event with valid params' do
      before_count = Event.count
      post company_unit_events_path(unit), xhr: true, params: params

      expect(Event.count).not_to eq(before_count)
      expect(response).to render_template(:create)
    end

    it 'does not create event with invalid params' do
      before_count = Event.count
      event_params[:title] = ''
      post company_unit_events_path(unit), xhr: true, params: params

      expect(Event.count).to eq(before_count)
      expect(response).to render_template(:create)
    end
  end

  describe 'PATCH /company/units/:id' do
    it 'updates event if data is valid' do
      patch company_unit_event_path(unit, event),
            xhr: true, params: params

      expect(Event.find(event.id).title)
        .to eq(event_params[:title])
      expect(response).to render_template(:update)
    end

    it 'does not update event with invalid params' do
      event_params[:title] = ''
      patch company_unit_event_path(unit, event),
            xhr: true, params: params

      expect(Event.find(event.id).title)
        .not_to eq(event_params[:title])
      expect(response).to render_template(:update)
    end
  end

  describe 'DELETE /company/units/:unit_id/events/:id' do
    it 'deletes unit and redirects to units page' do
      delete company_unit_event_path(unit, event), xhr: true

      expect(response).to render_template(:destroy)
    end
  end
end
