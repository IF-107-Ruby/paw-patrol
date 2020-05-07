require 'rails_helper'

RSpec.describe RoomEmployeesController, type: :controller do
  let!(:company) { create(:company) }
  let!(:user) { create(:user, company: company) }
  let!(:unit) { create(:unit, company: company) }

  before { sign_in user }

  describe 'GET #index' do
    subject do
      get :index, params: { unit_id: unit }
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(subject).to render_template('index') }
  end
end
