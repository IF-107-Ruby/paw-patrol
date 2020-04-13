require 'rails_helper'

RSpec.describe FeedbacksController, type: :controller do
  let(:feedback) { create(:feedback) }
  let(:feedback_valid_params) { FactoryBot.attributes_for :feedback }
  let(:feedback_invalid_params) { { user_full_name: '', email: '', describe: '' } }

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

      it { is_expected.to render_template('home/index') }
    end
  end

  describe 'DELETE #destroy' do
    before { delete :destroy, params: { id: feedback.id } }

    it { is_expected.to set_flash[:success] }
    it { is_expected.to redirect_to(feedbacks_path) }
  end
end