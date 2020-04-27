require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  let!(:owner) { create(:user) }
  let!(:employee) { create(:user) }

  let!(:company) { create(:company) }

  let!(:company_owner) { create(:company_owner, company: company, user: owner) }
  let!(:company_employee) { create(:employee, company: company, user: employee) }

  subject { described_class }

  permissions :new? do
    it 'grant access' do
      expect(subject).to permit(owner)
    end

    it 'denied access' do
      expect(subject).not_to permit(employee)
    end
  end

  permissions :create? do
    it 'grant access' do
      expect(subject).to permit(owner)
    end

    it 'denied access' do
      expect(subject).not_to permit(employee)
    end
  end
end
