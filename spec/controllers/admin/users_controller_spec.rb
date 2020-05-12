require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let!(:admin) { create(:admin) }
  let!(:user) { create(:user) }
  let!(:valid_params) { FactoryBot.attributes_for :user }
  let!(:invalid_params) { { first_name: '' } }

  before { sign_in admin }

  describe 'GET #index' do
    subject do
      get :index
    end
    it { expect(response).to have_http_status(:success) }
    it { expect(subject).to render_template('index') }
  end

  describe 'GET#show' do
    before do
      get :show, params: { id: user.id }
    end
    it 'returns success and assigns user' do
      expect(response).to have_http_status(:success)
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'GET#edit' do
    context 'admin edit admin profile' do
      before do
        get :edit, params: { id: admin.id }
      end
      it 'returns http success and assign user' do
        expect(response).to have_http_status(:success)
        expect(assigns(:user)).to eq(admin)
      end
    end
  end

  describe 'GET#edit' do
    context 'admin edit user profile' do
      before do
        get :edit, params: { id: user.id }
      end
      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
        expect(subject).not_to render_template('edit')
      end
    end
  end

  describe 'PUT#update' do
    context 'with valid params' do
      before do
        put :update, params: { id: admin.id,
                               user: valid_params.merge!(first_name: 'Another',
                                                         last_name: 'User') }
      end
      it 'assigns the user' do
        expect(assigns(:user)).to eq(admin)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admin_user_path(admin))
      end
      it 'updates user attributes' do
        admin.reload
        expect(admin.first_name).to eq(valid_params[:first_name])
        expect(admin.last_name).to eq(valid_params[:last_name])
      end
    end
    context 'with invalid params' do
      it 'does not change user' do
        expect do
          put :update, params: { id: admin.id, user: invalid_params }
        end.not_to change { admin.reload.first_name }
        expect do
          put :update, params: { id: admin.id, user: invalid_params }
        end.not_to change { admin.reload.last_name }
      end
    end
  end

  describe 'DELETE#destroy' do
    it 'destroys the user and redirects to index' do
      expect { delete :destroy, params: { id: user.id } }
        .to change(User, :count).by(-1)
      expect(response).to redirect_to(admin_users_path)
    end
  end

  describe 'POST#impersonate' do
    before do
      post :impersonate, params: { id: user.id }
    end
    it 'returns success and assigns user' do
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'POST#stop_impersonating' do
    before do
      post :stop_impersonating
    end
    it 'returns success and assigns user' do
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(root_path)
    end
  end
end
