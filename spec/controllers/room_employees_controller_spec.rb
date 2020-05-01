require 'rails_helper'

RSpec.describe RoomEmployeesController, type: :controller do
  let(:users_units_relationship) { create(:users_units_relationship) }

  describe 'GET #index' do
    subject do 
      get :index, params: { unit_id: users_units_relationship.unit }
    end 

    it { is_expected.to have_http_status(:success) }
    it { is_expected.to render_template('index') }
  end
end