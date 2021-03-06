require 'rails_helper'

RSpec.describe Company::CompanyPolicy, type: :policy do
  include_context 'company with users'
  subject { described_class }

  permissions :show? do
    it 'grant access' do
      expect(subject).to permit(company_owner)
      expect(subject).to permit(employee)
      expect(subject).to permit(staff_member)
    end
  end

  permissions :update? do
    it 'grant access' do
      expect(subject).to permit(company_owner)
    end

    it 'denie access' do
      expect(subject).not_to permit(employee)
      expect(subject).not_to permit(staff_member)
    end
  end

  permissions :destroy? do
    it 'grant access' do
      expect(subject).to permit(company_owner)
    end

    it 'denie access' do
      expect(subject).not_to permit(employee)
      expect(subject).not_to permit(staff_member)
    end
  end
end
