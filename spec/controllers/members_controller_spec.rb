require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  let(:users_companies_relationship) { create(:users_companies_relationship) }

  before { sign_in users_companies_relationship.user }

  describe 'GET #index' do
    subject do
      get :index, params: { company_id: users_companies_relationship.company.id }
    end

    it { is_expected.to have_http_status(:success) }
    it { is_expected.to render_template('index') }
  end
end
