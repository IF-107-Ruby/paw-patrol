require 'rails_helper'

describe UsersController, type: :controller do
  let!(:company) { create(:company) }
  let!(:company_owner_relationship) do
    create(:company_owner_relationship, company: company)
  end
  let!(:valid_params) { FactoryBot.attributes_for :user }
  let!(:invalid_params) { { first_name: '' } }

  before { sign_in company_owner_relationship.user }

  describe 'GET#show' do
    before do
      get :show, params: { id: company_owner_relationship.user.id }
    end
    it 'returns success and assigns user' do
      expect(response).to have_http_status(:success)
      expect(assigns(:user)).to eq(company_owner_relationship.user)
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
        expect(response).to redirect_to(company_members_path(company))
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
      get :edit, params: { id: company_owner_relationship.user.id }
    end
    it 'returns http success and assign user' do
      expect(response).to have_http_status(:success)
      expect(assigns(:user)).to eq(company_owner_relationship.user)
    end
  end

  describe 'PUT#update' do
    context 'with valid params' do
      before do
        put :update, params: { id: company_owner_relationship.user.id,
                               user: valid_params.merge!(first_name: 'Another',
                                                         last_name: 'User') }
      end
      it 'assigns the user' do
        expect(assigns(:user)).to eq(company_owner_relationship.user)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(user_path(company_owner_relationship.user))
      end
      it 'updates user attributes' do
        company_owner_relationship.user.reload
        expect(company_owner_relationship.user.first_name)
          .to eq(valid_params[:first_name])
        expect(company_owner_relationship.user.last_name).to eq(valid_params[:last_name])
      end
    end
    context 'with invalid params' do
      it 'does not change user' do
        expect do
          put :update, params: { id: company_owner_relationship.user.id,
                                 user: invalid_params }
        end.not_to change { company_owner_relationship.user.reload.first_name }
        expect do
          put :update, params: { id: company_owner_relationship.user.id,
                                 user: invalid_params }
        end.not_to change { company_owner_relationship.user.reload.last_name }
      end
    end
  end

  describe 'DELETE#destroy' do
    it 'destroys the user and redirects to index' do
      expect { delete :destroy, params: { id: company_owner_relationship.user.id } }
        .to change(User, :count).by(-1)
      expect(response).to redirect_to(users_path)
    end
  end
end
