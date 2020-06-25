require 'rails_helper'

RSpec.describe Admin::DashboardsController, type: :controller do
  let(:admin) { create(:admin) }

  describe 'GET#index' do
    before do
      sign_in admin
      get :index
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(subject).to render_template('index') }
  end
end
