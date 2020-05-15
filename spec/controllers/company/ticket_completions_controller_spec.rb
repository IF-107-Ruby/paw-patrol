require 'rails_helper'

describe Company::TicketCompletionsController, type: :controller do
  include_context 'company with unit, ticket and ticket completion'

  describe 'Authentication and authorization tests' do
    context 'if user can\'t create ticket completion' do
      before do
        sign_in unit.users.last
      end

      describe 'GET #new' do
        subject { get :new, params: { ticket_id: unit.tickets.last.id } }

        it { is_expected.to have_http_status(:redirect) }
        it { is_expected.not_to render_template('new') }
      end
    end

    context 'if user can create ticket' do
      before do
        sign_in unit.responsible_user
      end

      describe 'GET #new' do
        subject { get :new, params: { ticket_id: unit.tickets.last.id } }

        it { is_expected.to have_http_status(:success) }
        it { is_expected.to render_template('new') }
      end

      describe 'POST #create' do
        let(:ticket_completion_valid_params) do
          FactoryBot.attributes_for :ticket_completion
        end
        let(:ticket_completion_invalid_params) { { description: '' } }

        context 'with valid params' do
          before do
            post :create, params: {
              ticket_completion: ticket_completion_valid_params,
              ticket_id: unit.tickets.last.id
            }
          end

          it { is_expected.not_to set_flash.now[set_flash.now[:warning]] }
        end

        context 'with invalid params' do
          before do
            post :create, params: {
              ticket_completion: ticket_completion_invalid_params,
              ticket_id: unit.tickets.last.id
            }
          end

          it { is_expected.to set_flash.now[:warning] }
          it { is_expected.not_to set_flash[:success] }
          it { is_expected.to render_template('new') }
        end
      end
    end
  end
end
