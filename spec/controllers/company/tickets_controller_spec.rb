require 'rails_helper'

describe Company::TicketsController, type: :controller do
  include_context 'employee with ticket'
  let!(:user) { create(:staff_member, company: company) }

  describe 'GET #show' do
    before do
      sign_in employee
    end

    subject { get :show, params: { id: ticket.id } }

    it { is_expected.to have_http_status(:success) }
    it { is_expected.to render_template('show') }
  end

  describe 'Authentication and authorization tests' do
    context 'if user can\'t create ticket' do
      before do
        sign_in user
      end

      describe 'GET #new' do
        subject { get :new }

        it { is_expected.to have_http_status(:redirect) }
        it { is_expected.not_to render_template('new') }
      end

      describe 'GET #resolved' do
        before do
          ticket.resolved!
        end

        subject { get :resolved }

        it { is_expected.to have_http_status(:redirect) }
        it { is_expected.not_to render_template('resolved') }
      end
    end

    context 'if user can create ticket' do
      before do
        sign_in employee
      end

      describe 'GET #new' do
        subject { get :new }

        it { is_expected.to have_http_status(:success) }
        it { is_expected.to render_template('new') }
      end

      describe 'GET #resolved' do
        before do
          ticket.resolved!
        end

        subject { get :resolved }

        it { is_expected.to have_http_status(:success) }
        it { is_expected.to render_template('resolved') }
      end

      describe 'POST #create' do
        let(:ticket_valid_params) { FactoryBot.attributes_for :ticket }
        let(:ticket_invalid_params) { { name: '', description: '' } }

        context 'with valid params' do
          before { post :create, params: { ticket: ticket_valid_params } }

          it { is_expected.not_to set_flash.now[set_flash.now[:warning]] }
        end

        context 'with invalid params' do
          before { post :create, params: { ticket: ticket_invalid_params } }

          it { is_expected.to set_flash.now[:warning] }
          it { is_expected.not_to set_flash[:success] }
          it { is_expected.to render_template('new') }
        end
      end
    end
  end
end
