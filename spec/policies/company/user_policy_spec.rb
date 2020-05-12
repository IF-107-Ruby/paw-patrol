require 'rails_helper'

RSpec.describe Company::UserPolicy, type: :policy do
  include_context 'company with users'
  subject { described_class }

  permissions :index? do
    it 'grant access' do
      expect(subject).to permit(company_owner, company_owner)
      expect(subject).to permit(company_owner, employee)
      expect(subject).to permit(company_owner, staff_member)

      expect(subject).to permit(employee, company_owner)
      expect(subject).to permit(employee, employee)
      expect(subject).to permit(employee, staff_member)

      expect(subject).to permit(staff_member, company_owner)
      expect(subject).to permit(staff_member, employee)
      expect(subject).to permit(staff_member, staff_member)
    end
  end

  permissions :show? do
    it 'grant access' do
      expect(subject).to permit(company_owner, company_owner)
      expect(subject).to permit(company_owner, employee)
      expect(subject).to permit(company_owner, staff_member)

      expect(subject).to permit(employee, company_owner)
      expect(subject).to permit(employee, employee)
      expect(subject).to permit(employee, staff_member)

      expect(subject).to permit(staff_member, company_owner)
      expect(subject).to permit(staff_member, employee)
      expect(subject).to permit(staff_member, staff_member)
    end
  end

  permissions :update? do
    it 'grant access' do
      expect(subject).to permit(company_owner, employee)
      expect(subject).to permit(company_owner, staff_member)
    end

    it 'denie access' do
      expect(subject).not_to permit(company_owner, company_owner)

      expect(subject).not_to permit(employee, company_owner)
      expect(subject).not_to permit(employee, employee)
      expect(subject).not_to permit(employee, staff_member)

      expect(subject).not_to permit(staff_member, company_owner)
      expect(subject).not_to permit(staff_member, employee)
      expect(subject).not_to permit(staff_member, staff_member)
    end
  end

  permissions :destroy? do
    it 'grant access' do
      expect(subject).to permit(company_owner, employee)
      expect(subject).to permit(company_owner, staff_member)
    end

    it 'denie access' do
      expect(subject).not_to permit(company_owner, company_owner)

      expect(subject).not_to permit(employee, company_owner)
      expect(subject).not_to permit(employee, employee)
      expect(subject).not_to permit(employee, staff_member)

      expect(subject).not_to permit(staff_member, company_owner)
      expect(subject).not_to permit(staff_member, employee)
      expect(subject).not_to permit(staff_member, staff_member)
    end
  end
end
