require 'rails_helper'

RSpec.describe Company::EventPolicy, type: :policy do
  include_context 'company with users'
  let(:unit) { create(:unit, company: company, responsible_user: staff_member) }
  let(:event) { create(:event, unit: unit, user: staff_member) }

  subject { described_class }

  permissions :index? do
    it 'grant access' do
      expect(subject).to permit(company_owner, event)
      expect(subject).to permit(employee, event)
      expect(subject).to permit(staff_member, event)
    end
  end

  permissions :show? do
    it 'grant access' do
      expect(subject).to permit(company_owner, event)
      expect(subject).to permit(employee, event)
      expect(subject).to permit(staff_member, event)
    end
  end

  permissions :create? do
    it 'grant access' do
      expect(subject).to permit(company_owner, event)
      expect(subject).to permit(staff_member, event)
    end

    it 'denie access' do
      expect(subject).not_to permit(employee, event)
    end
  end

  permissions :update? do
    it 'grant access' do
      expect(subject).to permit(company_owner, event)
      expect(subject).to permit(staff_member, event)
    end

    it 'denie access' do
      expect(subject).not_to permit(employee, event)
    end
  end

  permissions :destroy? do
    it 'grant access' do
      expect(subject).to permit(company_owner, event)
      expect(subject).to permit(staff_member, event)
    end

    it 'denie access' do
      expect(subject).not_to permit(employee, event)
    end
  end
end
