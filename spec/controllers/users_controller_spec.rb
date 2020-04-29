require 'rails_helper'

describe UsersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:valid_params) { FactoryBot.attributes_for :user }
  let!(:invalid_params) { { first_name: '' } }

  describe 'GET#index' do
    it 'assigns users and renders template' do
      get :index
      expect(assigns(:users)).to eq([user])
      expect(response).to render_template('index')
    end
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

  describe 'GET#new' do
    it 'returns success and assigns user' do
      get :new
      expect(response).to have_http_status(:success)
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST#create' do
    context 'with valid params' do
      it 'creates a new user' do
        expect do
          post :create, params: { user: valid_params }
        end.to change(User, :count).by(1)
      end
      it 'redirects to the created user' do
        post :create, params: { user: valid_params }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(user_path(User.last))
      end
    end
    context 'with invalid params' do
      it 'do not create a new user' do
        expect do
          post :create, params: { user: invalid_params }
        end.not_to change(User, :count)
      end
    end
  end

  describe 'GET#edit' do
    before do
      get :edit, params: { id: user.id }
    end
    it 'returns http success and assign user' do
      expect(response).to have_http_status(:success)
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'PUT#update' do
    context 'with valid params' do
      before do
        put :update, params: { id: user.id,
                               user: valid_params.merge!(first_name: 'Another',
                                                         last_name: 'User') }
      end
      it 'assigns the user' do
        expect(assigns(:user)).to eq(user)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(user_path(user))
      end
      it 'updates user attributes' do
        user.reload
        expect(user.first_name).to eq(valid_params[:first_name])
        expect(user.last_name).to eq(valid_params[:last_name])
      end
    end
    context 'with invalid params' do
      it 'does not change user' do
        expect do
          put :update, params: { id: user.id, user: invalid_params }
        end.not_to change { user.reload.first_name }
        expect do
          put :update, params: { id: user.id, user: invalid_params }
        end.not_to change { user.reload.last_name }
      end
    end
  end

  describe 'DELETE#destroy' do
    it 'destroys the user and redirects to index' do
      expect { delete :destroy, params: { id: user.id } }
        .to change(User, :count).by(-1)
      expect(response).to redirect_to(users_path)
    end
  end
end
