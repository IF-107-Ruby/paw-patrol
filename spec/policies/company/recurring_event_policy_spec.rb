require 'rails_helper'

RSpec.describe Company::RecurringEventPolicy, type: :policy do
  include_context 'company with users'
  let(:unit) { create(:unit, company: company, responsible_user: staff_member) }
  let(:recurring_event) { create(:recurring_event, unit: unit, user: staff_member) }

  subject { described_class }

  permissions :index? do
    it 'grant access' do
      expect(subject).to permit(company_owner, recurring_event)
      expect(subject).to permit(employee, recurring_event)
      expect(subject).to permit(staff_member, recurring_event)
    end
  end

  permissions :show? do
    it 'grant access' do
      expect(subject).to permit(company_owner, recurring_event)
      expect(subject).to permit(employee, recurring_event)
      expect(subject).to permit(staff_member, recurring_event)
    end
  end

  permissions :create? do
    it 'grant access' do
      expect(subject).to permit(company_owner, recurring_event)
      expect(subject).to permit(staff_member, recurring_event)
    end

    it 'denie access' do
      expect(subject).not_to permit(employee, recurring_event)
    end
  end

  permissions :update? do
    it 'grant access' do
      expect(subject).to permit(company_owner, recurring_event)
      expect(subject).to permit(staff_member, recurring_event)
    end

    it 'denie access' do
      expect(subject).not_to permit(employee, recurring_event)
    end
  end

  permissions :destroy? do
    it 'grant access' do
      expect(subject).to permit(company_owner, recurring_event)
      expect(subject).to permit(staff_member, recurring_event)
    end

    it 'denie access' do
      expect(subject).not_to permit(employee, recurring_event)
    end
  end
end
