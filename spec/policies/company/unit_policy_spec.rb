require 'rails_helper'

RSpec.describe Company::UnitPolicy, type: :policy do
  include_context 'company with users'
  let(:unit) { create(:unit, company: company) }

  subject { described_class }

  permissions :index? do
    it 'grant access' do
      expect(subject).to permit(company_owner, unit)
      expect(subject).to permit(employee, unit)
      expect(subject).to permit(staff_member, unit)
    end
  end

  permissions :show? do
    it 'grant access' do
      expect(subject).to permit(company_owner, unit)
      expect(subject).to permit(employee, unit)
      expect(subject).to permit(staff_member, unit)
    end
  end

  permissions :children? do
    it 'grant access' do
      expect(subject).to permit(company_owner, unit)
      expect(subject).to permit(employee, unit)
      expect(subject).to permit(staff_member, unit)
    end
  end

  permissions :create? do
    it 'grant access' do
      expect(subject).to permit(company_owner, unit)
    end

    it 'denie access' do
      expect(subject).not_to permit(employee, unit)
      expect(subject).not_to permit(staff_member, unit)
    end
  end

  permissions :update? do
    it 'grant access' do
      expect(subject).to permit(company_owner, unit)
    end

    it 'denie access' do
      expect(subject).not_to permit(employee, unit)
      expect(subject).not_to permit(staff_member, unit)
    end
  end

  permissions :destroy? do
    it 'grant access' do
      expect(subject).to permit(company_owner, unit)
    end

    it 'denie access' do
      expect(subject).not_to permit(employee, unit)
      expect(subject).not_to permit(staff_member, unit)
    end
  end
end
