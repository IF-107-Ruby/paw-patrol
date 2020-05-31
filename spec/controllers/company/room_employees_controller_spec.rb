require 'rails_helper'

RSpec.describe Company::RoomEmployeesController, type: :controller do
  let!(:company) { create(:company) }
  let!(:company_owner) { create(:company_owner, company: company) }
  let!(:staff_member) { create(:staff_member, company: company) }
  let!(:employee) { create(:employee, company: company) }
  let!(:unit) { create(:unit, company: company) }

  before { sign_in company_owner }

  describe 'GET#show' do
    subject do
      get :show, params: { unit_id: unit }
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(subject).to render_template('show') }
  end

  describe 'GET#edit' do
    subject do
      get :edit, params: { unit_id: unit }
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(subject).to render_template('edit') }
  end

  describe 'PUT#update' do
    context 'update room employees' do
      before do
        put :update, params: { unit_id: unit.id,
                               unit: { user_ids: [staff_member.id, employee.id] } }
      end

      it 'returns redirect status' do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(company_unit_room_employees_path(unit))
        expect(flash[:success]).to be_present
      end

      it 'adds new employees' do
        unit.reload
        expect(unit.users).to include(staff_member)
        expect(unit.users).to include(employee)
      end
    end
  end
end
