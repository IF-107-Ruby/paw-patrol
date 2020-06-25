require 'rails_helper'

RSpec.describe FeedbacksController, type: :controller do
  let(:feedback_valid_params) { FactoryBot.attributes_for :feedback }
  let(:feedback_invalid_params) { { user_full_name: '', email: '', message: '' } }

  describe 'Get #new' do
    before do
      get :new
    end

    it 'initiates empty feedback object' do
      expect(assigns(:feedback)).to be_a_new(Feedback)
    end

    it 'render new template' do
      expect(response).to have_http_status(:success)
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'create a new feedback' do
        expect do
          post :create, params: { feedback: feedback_valid_params }
        end.to change(Feedback, :count).by(1)
      end

      it 'redirects to the root path' do
        post :create, params: { feedback: feedback_valid_params }

        is_expected.to set_flash[:success]
        is_expected.to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      it 'cannot create a new feedback' do
        expect do
          post :create, params: { feedback: feedback_invalid_params }
        end.to change(Feedback, :count).by(0)
      end

      it 'render new template' do
        post :create, params: { feedback: feedback_invalid_params }

        is_expected.to set_flash.now[:warning]
        is_expected.not_to set_flash[:success]
        is_expected.to render_template('new')
      end
    end
  end
end
