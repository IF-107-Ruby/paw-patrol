require 'rails_helper'

RSpec.describe Company::UserUnitPolicy, type: :policy do
  include_context 'company with users'

  subject { Company::UserUnitPolicy }

  let!(:unit) { create(:unit, :with_employee_and_ticket, company: company) }
  let!(:employee_with_unit) { unit.users.first }

  permissions :index? do
    it 'grant access' do
      expect(subject).not_to permit(company_owner, unit)
      expect(subject).not_to permit(employee, unit)
      expect(subject).not_to permit(staff_member, unit)
      expect(subject).to permit(employee_with_unit, unit)
    end
  end

  permissions :show? do
    it 'grant access' do
      expect(subject).not_to permit(company_owner, unit)
      expect(subject).not_to permit(employee, unit)
      expect(subject).not_to permit(staff_member, unit)
      expect(subject).to permit(employee_with_unit, unit)
    end
  end
end
