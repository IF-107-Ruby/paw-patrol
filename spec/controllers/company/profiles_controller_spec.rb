require 'rails_helper'

RSpec.describe Company::ProfilesController, type: :controller do
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
    before { get :edit }

    it 'return user object' do
      expect(assigns(:user)).to eq(employee)
    end

    it 'render edit template' do
      expect(response).to have_http_status(:success)
      expect(response).to render_template('edit')
    end
  end

  describe 'Patch#Update' do
    context 'With valid params' do
      before do
        put :update, params: { user: FactoryBot.attributes_for(:user) }
      end

      it { is_expected.to set_flash[:success] }
      it { is_expected.to redirect_to(company_profile_path) }
    end

    context 'With invalid params' do
      before do
        put :update, params: { user: { first_name: '', last_name: '' } }
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
          user: { current_password: user_password,
                  password: user_password.reverse,
                  password_confirmation: user_password.reverse }
        }
      end

      it { is_expected.to set_flash[:success] }
      it { is_expected.to redirect_to(company_profile_path) }
    end

    context 'With incorrect current password' do
      before do
        put :update_password, params: {
          user: { current_password: 'asdasdasd',
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
          user: { current_password: user_password,
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
