require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, :with_company) }

  describe 'Associations' do
    it { is_expected.to have_one(:users_companies_relationship).dependent(:destroy) }
    it { is_expected.to have_one(:company).through(:users_companies_relationship) }
    it { is_expected.to have_many(:tickets).dependent(:destroy) }
    it { is_expected.to have_many(:assigned_tickets) }
    it { is_expected.to have_many(:users_units_relationships).dependent(:destroy) }
    it { is_expected.to have_many(:units).through(:users_units_relationships) }
    it { is_expected.to have_many(:events).dependent(:nullify) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:email) }
  end

  it 'User has role' do
    expect(user.role).to eq(user.role)
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

  it 'sends an invitation email' do
    expect { UserMailer.invitation_email(user, user.password).deliver_now }
      .to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  describe 'avatar validation' do
    it do
      is_expected.to validate_content_type_of(:avatar).allowing('image/png',
                                                                'image/jpg',
                                                                'image/jpeg')
    end
    it { is_expected.to validate_size_of(:avatar).less_than(1.megabytes) }
  end
end
