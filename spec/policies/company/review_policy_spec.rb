require 'rails_helper'

RSpec.describe Company::ReviewPolicy, type: :policy do
  include_context 'company with users'

  subject { described_class }

  permissions :index? do
    it 'grant access' do
      expect(subject).to permit(company_owner)
      expect(subject).to permit(employee)
    end

    it 'denied access' do
      expect(subject).not_to permit(staff_member)
    end
  end

  permissions :create? do
    it 'grant access' do
      expect(subject).to permit(company_owner)
      expect(subject).to permit(employee)
    end

    it 'denied access' do
      expect(subject).not_to permit(staff_member)
    end
  end

  permissions :update? do
    it 'grant access' do
      expect(subject).to permit(company_owner)
      expect(subject).to permit(employee)
    end

    it 'denied access' do
      expect(subject).not_to permit(staff_member)
    end
  end
end
