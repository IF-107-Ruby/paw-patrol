require 'rails_helper'

RSpec.describe Company::DashboardsController, type: :controller do
  render_views

  let!(:company) { create(:company) }
  let!(:employee) { create(:employee, company: company) }
  let!(:company_owner) { create(:company_owner, company: company) }

  describe 'GET#show' do
    before do
      sign_in employee
      get :show
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(subject).to render_template('show') }
  end

  describe 'GET#satisfaction' do
    context 'company owner sees satisfaction' do
      before do
        sign_in company_owner
        get :show
      end

      it { expect(response).to have_http_status(:success) }
      it { expect(subject).to render_template('show') }
      it { expect(flash[:warning]).not_to be_present }
    end
  end
end
