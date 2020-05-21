require 'rails_helper'

RSpec.describe Company::TicketPolicy, type: :policy do
  include_context 'company with users'
  include_context 'unit with ticket and resolution'

  subject { described_class }

  permissions :create? do
    it 'grant access' do
      expect(subject).to permit(company_owner)
      expect(subject).to permit(employee)
    end

    it 'denied access' do
      expect(subject).not_to permit(staff_member)
    end
  end

  permissions :resolved? do
    it 'grant access' do
      expect(subject).to permit(company_owner)
      expect(subject).to permit(employee)
    end

    it 'denied access' do
      expect(subject).not_to permit(staff_member)
  end

  permissions :resolution? do
    it 'grant access' do
      expect(subject).to permit(unit.responsible_user, unit.tickets.last)
    end

    it 'denied access' do
      expect(subject).not_to permit(company_owner, unit.tickets.last)
      expect(subject).not_to permit(employee, unit.tickets.last)
    end
  end
end
