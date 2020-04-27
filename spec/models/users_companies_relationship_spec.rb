# == Schema Information
#
# Table name: users_companies_relationships
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  company_id :bigint           not null
#  role       :integer          default("company_owner"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe UsersCompaniesRelationship, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:company) }
  end

  describe 'validations' do
    context 'presence validation' do
      it { is_expected.to validate_presence_of(:user) }
      it { is_expected.to validate_presence_of(:company) }
      it { is_expected.to validate_presence_of(:role) }
    end
  end

  describe 'roles test\'s' do
    let(:company_owner) { create(:company_owner) }
    let(:employee) { create(:employee) }
    let(:staff_member) { create(:staff_member) }

    it do
      is_expected.to define_enum_for(:role)
        .with_values(company_owner: 0, employee: 1, staff_member: 2)
    end

    it 'he is company_owner' do
      expect(company_owner.company_owner?).to be true
      expect(company_owner.employee?).not_to be true
    end

    it 'he is employee' do
      expect(employee.employee?).to be true
      expect(company_owner.staff_member?).not_to be true
    end

    it 'he is staff_member' do
      expect(staff_member.staff_member?).to be true
      expect(staff_member.company_owner?).not_to be true
    end
  end
end
