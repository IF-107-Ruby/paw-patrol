require 'rails_helper'

RSpec.describe Company::SettingsController, type: :controller do
  render_views

  let!(:company) { create(:company) }
  let!(:employee) { create(:employee, company: company) }

  before do
    sign_in employee
  end

  describe 'Get#Edit' do
    subject { get :edit }

    it { is_expected.to have_http_status(:success) }
    it { is_expected.to render_template('edit') }
  end

  describe 'Patch#Update' do
    context 'With valid params' do
      before do
        put :update, params: { user_settings: FactoryBot.attributes_for(:user) }
      end

      it { is_expected.to set_flash[:success] }
      it { is_expected.to redirect_to(company_settings_path) }
    end

    context 'With invalid params' do
      before do
        put :update, params: { user_settings: { first_name: '', last_name: '' } }
      end

      it { is_expected.not_to set_flash[:success] }
      it { is_expected.to set_flash.now[:warning] }
      it { is_expected.to render_template('edit') }
    end
  end
end
