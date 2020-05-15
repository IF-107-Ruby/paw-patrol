require 'rails_helper'

RSpec.describe Company::TicketCompletionPolicy, type: :policy do
  include_context 'company with unit, ticket and ticket completion'

  subject { described_class }

  permissions :new? do
    it 'grant access' do
      expect(subject).to permit(unit.responsible_user, ticket_completion)
    end

    it 'denied access' do
      expect(subject).not_to permit(unit.users.last, ticket_completion)
    end
  end

  permissions :create? do
    it 'grant access' do
      expect(subject).to permit(unit.responsible_user, ticket_completion)
    end

    it 'denied access' do
      expect(subject).not_to permit(unit.users.last, ticket_completion)
    end
  end
end
