require 'rails_helper'

RSpec.describe Company::UserUnitPolicy, type: :policy do
  let!(:company) { create(:company) }
  let!(:unit) { create(:unit, :with_employee_and_ticket, company: company) }
  let!(:employee) { unit.users.first }
  let!(:company_owner) { create(:company_owner, company: company) }
  let!(:staff_member) { create(:staff_member, company: company) }

  subject { Company::UserUnitPolicy }

  permissions :index? do
    it 'grant access' do
      expect(subject).not_to permit(company_owner, unit)
      expect(subject).not_to permit(staff_member, unit)
      expect(subject).to permit(employee, unit)
    end
  end

  permissions :show? do
    it 'grant access' do
      expect(subject).not_to permit(company_owner, unit)
      expect(subject).not_to permit(staff_member, unit)
      expect(subject).to permit(employee, unit)
    end
  end
end
