require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  let(:company) { create(:company) }
  let(:users_companies_relationship) do
    create(:users_companies_relationship, company: company)
  end

  describe 'GET #index' do
    subject { get :index, params: { company_id: company.id } }

    it { is_expected.to have_http_status(:success) }
    it { is_expected.to render_template('index') }
  end
end
