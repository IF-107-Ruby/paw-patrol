require 'rails_helper'

RSpec.describe FeedbacksController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let(:feedback) { create(:feedback) }
  let(:feedback_valid_params) { FactoryBot.attributes_for :feedback }
  let(:feedback_invalid_params) { { user_full_name: '', email: '', describe: '' } }

  describe 'Authentication and authorization tests' do
    context 'if user is not admin' do
      before { sign_in user }

      describe 'GET #index' do
        subject { get :index }

        it { is_expected.to have_http_status(:redirect) }
        it { is_expected.not_to render_template('index') }
      end

      describe 'GET #show' do
        subject { get :show, params: { id: feedback.id } }

        it { is_expected.to have_http_status(:redirect) }
        it { is_expected.not_to render_template('show') }
      end

      describe 'DELETE #destroy' do
        before { delete :destroy, params: { id: feedback.id } }

        it { is_expected.not_to set_flash[:success] }
      end
    end

    context 'if user is admin' do
      before { sign_in admin }

      describe 'GET #index' do
        subject { get :index }

        it { is_expected.to have_http_status(:success) }
        it { is_expected.to render_template('index') }
      end

      describe 'GET #show' do
        subject { get :show, params: { id: feedback.id } }

        it { is_expected.to have_http_status(:success) }
        it { is_expected.to render_template('show') }
      end

      describe 'DELETE #destroy' do
        before { delete :destroy, params: { id: feedback.id } }

        it { is_expected.to set_flash[:success] }
        it { is_expected.to redirect_to(feedbacks_path) }
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      before { post :create, params: { feedback: feedback_valid_params } }

      it { is_expected.to set_flash[:success] }
      it { is_expected.not_to set_flash.now[set_flash.now[:warning]] }

      it { is_expected.to redirect_to(root_path) }
    end

    context 'with invalid params' do
      before { post :create, params: { feedback: feedback_invalid_params } }

      it { is_expected.to set_flash.now[:warning] }
      it { is_expected.not_to set_flash[:success] }

      it { is_expected.to render_template('static_pages/contact') }
    end
  end
end
