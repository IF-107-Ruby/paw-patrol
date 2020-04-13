require 'rails_helper'

describe CompaniesController, type: :controller do
  let!(:company) { create(:company) }
  let!(:valid_params) { FactoryBot.attributes_for :company }
  let!(:invalid_params) { { name: '' } }

  describe 'GET#index' do
    it 'assigns companies and renders template' do
      get :index
      expect(assigns(:companies)).to eq([company])
      expect(response).to render_template('index')
    end
  end

  describe 'GET#show' do
    before do
      get :show, params: { id: company.id }
    end
    it 'returns success and assigns company' do
      expect(response).to have_http_status(:success)
      expect(assigns(:company)).to eq(company)
    end
  end

  describe 'GET#new' do
    it 'returns success and assigns company' do
      get :new
      expect(response).to have_http_status(:success)
      expect(assigns(:company)).to be_a_new(Company)
    end
  end

  describe 'POST#create' do
    context 'with valid params' do
      it 'creates a new company' do
        expect { post :create, params: { company: valid_params } }
          .to change(Company, :count).by(1)
      end
      it 'redirects to the created company' do
        post :create, params: { company: valid_params }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(company_path(Company.last))
      end
    end
    context 'with invalid params' do
      it 'do not create a new company' do
        expect { post :create, params: { company: invalid_params } }
          .not_to change(Company, :count)
      end
    end
  end

  describe 'GET#edit' do
    before do
      get :edit, params: { id: company.id }
    end
    it 'returns http success and assign company' do
      expect(response).to have_http_status(:success)
      expect(assigns(:company)).to eq(company)
    end
  end

  describe 'PUT#update' do
    context 'with valid params' do
      before do
        put :update, params: { id: company.id,
                               company: valid_params.merge!(name: 'Another company') }
      end
      it 'assigns the company' do
        expect(assigns(:company)).to eq(company)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(company_path(company))
      end
      it 'updates company attributes' do
        company.reload
        expect(company.name).to eq(valid_params[:name])
      end
    end
    context 'with invalid params' do
      it 'does not change company' do
        expect { put :update, params: { id: company.id, company: invalid_params } }
          .not_to change { company.reload.name }
      end
    end
  end

  describe 'DELETE#destroy' do
    it 'destroys the company and redirects to index' do
      expect { delete :destroy, params: { id: company.id } }
        .to change(Company, :count).by(-1)
      expect(response).to redirect_to(companies_path)
    end
  end
end
