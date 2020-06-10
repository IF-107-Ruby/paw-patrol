require 'rails_helper'

RSpec.describe Admin::FeedbacksController, type: :controller do
  render_views

  let(:admin) { create(:admin) }
  let(:feedback) { create(:feedback) }

  describe 'Authentication and authorization tests' do
    context 'if not authenticated' do
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
        it { is_expected.to redirect_to(admin_feedbacks_path) }
      end
    end
  end
end
