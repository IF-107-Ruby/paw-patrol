require 'rails_helper'

describe CompaniesController, type: :controller do
  let(:company_registrations_form_valid_params) do
    attributes_for(:company_registrations_form_params)
  end
  let!(:user) { create(:user) }
  let!(:company) { create(:company) }
  let!(:valid_params) { attributes_for(:company) }
  let!(:invalid_params) { { name: '' } }

  describe 'GET#new' do
    it 'returns success and assigns company registration form' do
      get :new
      expect(response).to have_http_status(:success)
      expect(assigns(:company_registration)).to be_a(CompanyRegistrationsForm)
    end
  end

  describe 'POST#create' do
    context 'with valid params' do
      it 'creates a new company' do
        expect do
          post :create, params: {
            company_registrations_form: company_registrations_form_valid_params
          }
        end .to change(Company, :count).by(1)
      end

      it 'creates company owner' do
        expect do
          post :create, params: {
            company_registrations_form: company_registrations_form_valid_params
          }
        end.to change(User, :count).by(1)
      end

      it 'crates user_companies association' do
        expect do
          post :create, params: {
            company_registrations_form: company_registrations_form_valid_params
          }
        end.to change(UsersCompaniesRelationship, :count).by(1)
      end

      it 'redirects to the created company' do
        post :create, params: {
          company_registrations_form: company_registrations_form_valid_params
        }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid params' do
      it 'do not create a new company' do
        expect do
          post :create, params: {
            company_registrations_form: invalid_params
          }
        end.not_to change(Company, :count)
      end

      it 'do not create a new user' do
        expect { post :create, params: { company_registrations_form: invalid_params } }
          .not_to change(User, :count)
      end

      it 'do not create a new user_companies association' do
        expect { post :create, params: { company_registrations_form: invalid_params } }
          .not_to change(UsersCompaniesRelationship, :count)
      end
    end
  end
end
