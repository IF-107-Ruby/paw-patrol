require 'rails_helper'

describe TicketsController, type: :controller do
  before do
    @user = create(:user)
    sign_in @user
  end

  let(:ticket) { create(:ticket) }
  let(:ticket_valid_params) { FactoryBot.attributes_for :ticket }
  let(:ticket_invalid_params) { { name: '', description: '' } }

  describe 'GET #show' do
    subject { get :show, params: { id: ticket.id } }

    it { is_expected.to have_http_status(:success) }
    it { is_expected.to render_template('show') }
  end

  describe 'GET #new' do
    subject { get :new }

    it { is_expected.to have_http_status(:success) }
    it { is_expected.to render_template('new') }
  end

  describe 'POST #create' do
    context 'with valid params' do
      before { post :create, params: { ticket: ticket_valid_params } }

      it { is_expected.to set_flash[:success] }
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
