require 'rails_helper'

RSpec.describe Company::DashboardsController, type: :controller do
  let!(:company) { create(:company) }
  let!(:employee) { create(:employee, company: company) }

  describe 'GET#show' do
    before do
      sign_in employee
      get :show
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(subject).to render_template('show') }
  end
end
