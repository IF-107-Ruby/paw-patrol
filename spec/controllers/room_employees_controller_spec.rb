require 'rails_helper'

RSpec.describe RoomEmployeesController, type: :controller do
  let(:unit) { create(:unit, :with_users) }

  describe 'GET #index' do
    subject do
      get :index, params: { unit_id: unit }
    end

    it { is_expected.to have_http_status(:success) }
    it { is_expected.to render_template('index') }
  end
end
