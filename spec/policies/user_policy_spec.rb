require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  let!(:company) { create(:company) }

  let!(:company_owner) { create(:company_owner, company: company) }
  let!(:company_employee) { create(:employee, company: company) }

  subject { described_class }

  permissions :new? do
    it 'grant access' do
      expect(subject).to permit(company_owner)
    end

    it 'denied access' do
      expect(subject).not_to permit(company_employee)
    end
  end

  permissions :create? do
    it 'grant access' do
      expect(subject).to permit(company_owner)
    end

    it 'denied access' do
      expect(subject).not_to permit(company_employee)
    end
  end
end
