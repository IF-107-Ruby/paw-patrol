require 'rails_helper'

describe Company::ReviewsController do
  include_context 'employee with ticket'
  let!(:staff_member) { create(:staff_member, company: company) }
  let(:review_params) { FactoryBot.attributes_for :review }
  let(:review_invalid_params) { { rating: 0, comment: '' } }

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

    let!(:review) { create(:review, ticket: ticket) }

    subject { get :show, params: { id: review.id } }

    it { is_expected.to have_http_status(:success) }
    it { is_expected.to render_template('show') }
  end

  describe 'GET #new' do
    context 'Employee create review' do
      before { sign_in employee }

      subject { get :new, params: { ticket_id: ticket.id } }

      it { is_expected.to have_http_status(:success) }
      it { is_expected.to render_template('new') }
    end

    context 'Staff member create review' do
      before { sign_in staff_member }

      subject { get :new, params: { ticket_id: ticket.id } }

      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.not_to render_template('new') }
    end
  end

  describe 'GET #edit' do
    let!(:review) { create(:review, ticket: ticket) }
    context 'Employee edit review' do
      before { sign_in employee }

      subject { get :edit, params: { id: review.id } }

      it { is_expected.to have_http_status(:success) }
      it { is_expected.to render_template('edit') }
    end

    context 'Staff member edit review' do
      before { sign_in staff_member }

      subject { get :edit, params: { id: review.id } }

      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.not_to render_template('edit') }
    end
  end

  describe 'POST #create' do
    context 'Employee review ticket with valid params' do
      before do
        sign_in employee
        post :create, params: { review: review_params.merge(ticket_id: ticket.id) }
      end

      it { is_expected.to set_flash[:success] }
      it { is_expected.to redirect_to(company_reviews_path) }
    end

    context 'Employee review ticket with invalid params' do
      before do
        sign_in employee
        post :create,
             params: { review: review_invalid_params.merge(ticket_id: ticket.id) }
      end

      it { is_expected.not_to set_flash[:success] }
      it { is_expected.to set_flash.now[:warning] }
    end

    context 'Staff member review ticket' do
      before do
        sign_in staff_member
        post :create, params: { review: review_params.merge(ticket_id: ticket.id) }
      end

      it { is_expected.not_to set_flash[:success] }
    end
  end

  describe 'PUT#update' do
    let!(:review) { create(:review, ticket: ticket) }

    context 'Employee update review with invalid params' do
      before do
        sign_in employee
        put :update, params: { id: review.id,
                               review: review_params.merge(ticket_id: ticket.id) }
      end

      it { is_expected.to set_flash[:success] }
      it { is_expected.to redirect_to(company_reviews_path) }
    end

    context 'Employee update review with invalid params' do
      before do
        sign_in employee
        put :update, params: { id: review.id,
                               review: review_invalid_params.merge(ticket_id: ticket.id) }
      end

      it { is_expected.not_to set_flash[:success] }
      it { is_expected.to set_flash.now[:warning] }
    end

    context 'Staff member update review' do
      before do
        sign_in staff_member
        put :update, params: { id: review.id,
                               review: review_invalid_params.merge(ticket_id: ticket.id) }
      end

      it { is_expected.not_to set_flash[:success] }
    end
  end
end
