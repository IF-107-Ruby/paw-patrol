require 'rails_helper'

describe TicketsController, type: :controller do
  let!(:company) { create(:company) }
  let!(:unit) { create(:unit, :with_employee_and_ticket, company: company) }
  let!(:user) { create(:user) }
  let!(:employee) { unit.users.first }
  let!(:ticket) { unit.tickets.first }
  let(:ticket_valid_params) { FactoryBot.attributes_for :ticket }
  let(:ticket_invalid_params) { { name: '', description: '' } }

  describe 'GET #show' do
    before do
      sign_in employee
    end

    subject { get :show, params: { id: ticket.id } }

    it { is_expected.to have_http_status(:success) }
    it { is_expected.to render_template('show') }
  end

  describe 'Authentication and authorization tests' do
    context 'if user is not employee' do
      before do
        sign_in user
      end

      describe 'GET #new' do
        subject { get :new }

        it { is_expected.to have_http_status(:redirect) }
        it { is_expected.not_to render_template('new') }
      end
    end

    context 'if user is employee' do
      before do
        sign_in employee
      end

      describe 'GET #new' do
        subject { get :new }

        it { is_expected.to have_http_status(:success) }
        it { is_expected.to render_template('new') }
      end

      describe 'POST #create' do
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
