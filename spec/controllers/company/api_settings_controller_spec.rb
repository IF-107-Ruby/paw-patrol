require 'rails_helper'

RSpec.describe Company::ApiSettingsController, type: :controller do
  let!(:company) { create(:company) }
  let!(:company_owner) { create(:company_owner, company: company) }
  let!(:employee) { create(:employee, company: company) }

  describe 'GET#show' do
    before do
      sign_in company_owner
    end

    subject { get :show }

    it { is_expected.to have_http_status(:success) }
    it { is_expected.to render_template('show') }
  end

  describe 'PUT#update' do
    context 'enable api token' do
      before do
        sign_in company_owner
        put :update, params: { company: { enable_access_token: 1 } }
      end

      it 'returns redirect status and set enable to true' do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(company_api_settings_path)
        expect(company.reload.enable_access_token).to be_truthy
      end
    end
  end

  describe 'PUT#regenerate_api_token' do
    context 'company owner can update token' do
      before do
        sign_in company_owner
      end

      it 'updates api token' do
        expect do
          put :regenerate_api_token,
              params: { company: { access_token: SecureRandom.hex } }
        end
          .to change { company.reload.access_token }
      end
    end

    context 'employee can not update token' do
      before do
        sign_in employee
      end

      it 'does not update api token' do
        expect do
          put :regenerate_api_token,
              params: { company: { access_token: SecureRandom.hex } }
        end
          .not_to change { company.reload.access_token }
      end
    end
  end
end
