require 'rails_helper'

RSpec.describe Company::SettingsController, type: :controller do
  render_views

  let(:user_password) { '123456' }
  let!(:company) { create(:company) }
  let!(:employee) do
    create(:employee,
           password: user_password,
           password_confirmation: user_password,
           company: company)
  end

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

  describe 'Patch#Update_password' do
    context 'With valid params' do
      before do
        put :update_password, params: {
          user_password_settings: { current_password: user_password,
                                    password: user_password.reverse,
                                    password_confirmation: user_password.reverse }
        }
      end

      it { is_expected.to set_flash[:success] }
      it { is_expected.to redirect_to(company_settings_path) }
    end

    context 'With incorrect current password' do
      before do
        put :update_password, params: {
          user_password_settings: { current_password: 'asdasdasd',
                                    password: user_password.reverse,
                                    password_confirmation: user_password.reverse }
        }
      end

      it { is_expected.not_to set_flash[:success] }
      it { is_expected.to set_flash.now[:warning] }
      it { is_expected.to render_template('edit') }
    end

    context 'With invalid params' do
      before do
        put :update_password, params: {
          user_password_settings: { current_password: user_password,
                                    password: '1',
                                    password_confirmation: '2' }
        }
      end

      it { is_expected.not_to set_flash[:success] }
      it { is_expected.to set_flash.now[:warning] }
      it { is_expected.to render_template('edit') }
    end
  end
end
