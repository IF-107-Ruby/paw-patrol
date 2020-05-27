require 'rails_helper'

RSpec.describe Company::ResolvedTicketsController, type: :controller do
  include_context 'employee with ticket'

  let!(:staff_member) { create(:staff_member, company: company) }

  describe 'GET #index' do
    context 'User is employee' do
      before { sign_in employee }

      subject { get :index }

      it { is_expected.to have_http_status(:success) }
      it { is_expected.to render_template('index') }
    end

    context 'User is staff member' do
      before { sign_in staff_member }

      subject { get :index }

      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.not_to render_template('index') }
    end
  end
end
