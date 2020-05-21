require 'rails_helper'

RSpec.describe Company::ReviewPolicy, type: :policy do
  include_context 'employee with ticket'
  let!(:staff_member) { create(:staff_member, company: company) }
  let!(:company_owner) { create(:company_owner, company: company) }
  let!(:company_owner_ticket) do
    create(:ticket, user: company_owner, unit: company.units.first)
  end

  subject { described_class }

  permissions :index? do
    it 'grant access' do
      expect(subject).to permit(employee)
    end

    it 'denied access' do
      expect(subject).not_to permit(staff_member)
    end
  end

  permissions :create? do
    it 'grant access' do
      expect(subject).to permit(employee, Review.new(ticket_id: ticket.id))
      expect(subject).to permit(company_owner,
                                Review.new(ticket_id: company_owner_ticket.id))
    end

    it 'denied access' do
      expect(subject).not_to permit(employee,
                                    Review.new(ticket_id: company_owner_ticket.id))
      expect(subject).not_to permit(company_owner, Review.new(ticket_id: ticket.id))
      expect(subject).not_to permit(staff_member, Review.new(ticket_id: ticket.id))
    end
  end

  permissions :update? do
    it 'grant access' do
      expect(subject).to permit(employee, Review.new(ticket_id: ticket.id))
      expect(subject).to permit(company_owner,
                                Review.new(ticket_id: company_owner_ticket.id))
    end

    it 'denied access' do
      expect(subject).not_to permit(employee,
                                    Review.new(ticket_id: company_owner_ticket.id))
      expect(subject).not_to permit(company_owner, Review.new(ticket_id: ticket.id))
      expect(subject).not_to permit(staff_member, Review.new(ticket_id: ticket.id))
    end
  end
end
