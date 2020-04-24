require 'rails_helper'

RSpec.describe UnitsController, type: :controller do
  let!(:company) { create(:company) }
  let!(:owner) { create(:user) }
  let!(:company_owner) { create(:company_owner, company: company, user: owner) }
  let!(:unit) { create(:unit, company: company) }
  let!(:valid_params) { FactoryBot.attributes_for :unit }
  let!(:invalid_params) { { name: '' } }

  describe 'GET#index' do
    it 'assigns units and renders template' do
      get :index, params: { company_id: unit.company.id }
      expect(assigns(:units)).to eq([unit])
      expect(response).to render_template('index')
    end
  end

  describe 'GET#show' do
    before do
      get :show, params: { id: unit.id, company_id: unit.company.id }
    end
    it 'returns http success and assigns unit' do
      expect(response).to have_http_status(:success)
      expect(assigns(:unit)).to eq(unit)
    end
  end

  describe 'Units controller new, create, edit, update, destroy actions' do
    context 'if user is company owner' do
      before { sign_in owner }

      describe 'GET#new' do
        it 'returns http success and assigns unit' do
          get :new, params: { company_id: unit.company.id }
          expect(response).to have_http_status(:success)
          expect(assigns(:unit)).to be_a_new(Unit)
        end
      end

      describe 'POST#create' do
        context 'with valid params' do
          it 'creates a new unit' do
            expect do
              post :create, params: { unit: valid_params,
                                      company_id: unit.company.id }
            end.to change(Unit, :count).by(1)
          end

          it 'redirects to a new unit' do
            post :create, params: { unit: valid_params,
                                    company_id: unit.company.id }
            expect(response).to have_http_status(:redirect)
            expect(response).to redirect_to(company_unit_path(Unit.last.company,
                                                              Unit.last))
            expect(flash[:success]).to be_present
          end
        end
        context 'with invalid params' do
          it 'do not create new unit' do
            expect do
              post :create, params: { unit: invalid_params,
                                      company_id: unit.company.id }
            end.not_to change(Unit, :count)
          end
          it 'render new page with flash' do
            post :create, params: { unit: invalid_params,
                                    company_id: unit.company.id }
            expect(response).to have_http_status(:success)
            expect(flash[:danger]).to be_present
          end
        end
      end

      describe 'GET#edit' do
        before do
          get :edit, params: { id: unit.id, company_id: unit.company.id }
        end
        it 'returns http success and assign unit' do
          expect(response).to have_http_status(:success)
          expect(assigns(:unit)).to eq(unit)
        end
      end

      describe 'PUT#update' do
        context 'with valid params' do
          before do
            put :update, params: { id: unit.id,
                                   unit: valid_params.merge!(name: 'New name'),
                                   company_id: unit.company.id }
          end

          it 'assign the unit' do
            expect(assigns(:unit)).to eq(unit)
            expect(response).to have_http_status(:redirect)
            expect(response).to redirect_to(company_unit_path(unit.company, unit))
            expect(flash[:success]).to be_present
          end

          it 'updates unit name' do
            unit.reload
            expect(unit.name).to eq(valid_params[:name])
          end
        end
        context 'with invalid params' do
          it 'do not update unit' do
            expect do
              put :update, params: { id: unit.id, unit: invalid_params,
                                     company_id: unit.company.id }
            end
              .not_to change { unit.reload.name }
          end
          it 'render edit page with flash' do
            put :update, params: { id: unit.id, unit: invalid_params,
                                   company_id: unit.company.id }
            expect(response).to have_http_status(:success)
            expect(flash[:danger]).to be_present
          end
        end
      end

      describe 'DELETE#destroy' do
        it 'should delete unit' do
          expect do
            delete :destroy, params: { id: unit.id, company_id: unit.company.id }
          end.to change(Unit, :count).by(-1)
        end
        it 'should redirect to units' do
          delete :destroy, params: { id: unit.id, company_id: unit.company.id }
          expect(response).to have_http_status(:redirect)
          expect(response).to redirect_to(company_units_path(unit.company))
          expect(flash[:success]).to be_present
        end
      end
    end

    context 'if user is not company owner' do
      describe 'GET#new' do
        it 'returns redirect' do
          get :new, params: { company_id: unit.company.id }
          expect(response).to have_http_status(:redirect)
        end
      end

      describe 'POST#create' do
        it 'does not create a new unit' do
          expect do
            post :create, params: { unit: valid_params,
                                    company_id: unit.company.id }
          end.not_to change(Unit, :count)
          expect(flash[:success]).not_to be_present
        end
      end

      describe 'GET#edit' do
        before do
          get :edit, params: { id: unit.id, company_id: unit.company.id }
        end
        it 'returns redirect' do
          expect(response).to have_http_status(:redirect)
        end
      end

      describe 'DELETE#destroy' do
        it 'does not delete user' do
          expect do
            delete :destroy, params: { id: unit.id, company_id: unit.company.id }
          end.not_to change(Unit, :count)
        end
      end
    end
  end
end
