require 'rails_helper'

describe Company::ReviewsController do
  include_context 'employee with ticket'
  let!(:staff_member) { create(:staff_member, company: company) }
  let!(:review) { create(:review, ticket: ticket) }

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

  describe 'GET #show' do
    before { sign_in employee }

    subject { get :show, params: { id: review.id } }

    it { is_expected.to have_http_status(:success) }
    it { is_expected.to render_template('show') }
  end
end
