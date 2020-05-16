require 'rails_helper'

RSpec.describe 'Company::RecurringEvents', type: :request do
  let!(:company) { create(:company) }
  let!(:user) { create(:company_owner, company: company) }
  let!(:unit) { create(:unit, company: company) }
  let!(:recurring_event) { create(:recurring_event, unit: unit, user: user) }
  let(:recurring_event_params) { attributes_for(:recurring_event) }
  let(:params) { { recurring_event: recurring_event_params } }

  before { login_as user }

  describe 'GET /company/units/:unit_id/recurring_events' do
    it 'returns http success' do
      get company_unit_recurring_events_path(unit, format: :json)

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /company/units/:unit_id/recurring_events/:id' do
    it 'returns http success' do
      get company_unit_recurring_event_path(unit, recurring_event), xhr: true

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET /company/units/:unit_id/recurring_events/new' do
    it 'returns http success' do
      get new_company_unit_recurring_event_path(unit), xhr: true

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /company/units/:unit_id/recurring_events' do
    it 'creates recurring event with valid params' do
      before_count = RecurringEvent.count
      post company_unit_recurring_events_path(unit), xhr: true, params: params

      expect(RecurringEvent.count).not_to eq(before_count)
      expect(response).to render_template(:create)
    end

    it 'does not create recurring event with invalid params' do
      before_count = RecurringEvent.count
      recurring_event_params[:title] = ''
      post company_unit_recurring_events_path(unit), xhr: true, params: params

      expect(RecurringEvent.count).to eq(before_count)
      expect(response).to render_template(:create)
    end
  end

  describe 'PATCH /company/units/:id' do
    it 'updates recurring event if data is valid' do
      patch company_unit_recurring_event_path(unit, recurring_event),
            xhr: true, params: params

      expect(RecurringEvent.find(recurring_event.id).title)
        .to eq(recurring_event_params[:title])
      expect(response).to render_template(:update)
    end

    it 'does not update recurring event with invalid params' do
      recurring_event_params[:title] = ''
      patch company_unit_recurring_event_path(unit, recurring_event),
            xhr: true, params: params

      expect(RecurringEvent.find(recurring_event.id).title)
        .not_to eq(recurring_event_params[:title])
      expect(response).to render_template(:update)
    end
  end

  describe 'DELETE /company/units/:unit_id/recurring_events/:id' do
    it 'deletes unit and redirects to units page' do
      delete company_unit_recurring_event_path(unit, recurring_event), xhr: true

      expect(response).to render_template(:destroy)
    end
  end
end
