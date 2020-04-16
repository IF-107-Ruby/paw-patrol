require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'Associations' do
    it { is_expected.to have_one(:users_companies_relationship).dependent(:destroy) }
    it { is_expected.to have_one(:company).through(:users_companies_relationship) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it { should validate_presence_of(:last_name) }

    it { should validate_presence_of(:first_name) }

    it { should validate_presence_of(:email) }
  end
end
