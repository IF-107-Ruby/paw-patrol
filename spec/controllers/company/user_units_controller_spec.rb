require 'rails_helper'

RSpec.describe Company::UserUnitsController, type: :controller do
  render_views

  let!(:company) { create(:company) }
  let!(:unit) { create(:unit, :with_employee_and_ticket, company: company) }
  let!(:employee) { unit.users.first }
  let!(:user) { create(:staff_member, company: company) }

  describe 'User Units controller actions' do
    context 'if user is employee' do
      before { sign_in employee }

      describe 'GET#index' do
        it 'assigns units and renders template' do
          get :index, params: { user_id: employee.id }
          expect(assigns(:units)).to eq([unit])
          expect(response).to render_template('index')
        end
      end

      describe 'GET#show' do
        before do
          get :show, params: { id: unit.id }
        end
        it 'returns http success and assigns unit' do
          expect(response).to have_http_status(:success)
          expect(assigns(:unit)).to eq(unit)
        end
      end
    end

    context 'if user is not employee' do
      before { sign_in user }

      describe 'GET#index' do
        it 'returns redirect' do
          get :index, params: { user_id: user.id }
          expect(response).to have_http_status(:redirect)
        end
      end

      describe 'GET#show' do
        before do
          get :show, params: { id: unit.id }
        end
        it 'returns redirect' do
          expect(response).to have_http_status(:redirect)
        end
      end
    end
  end
end
