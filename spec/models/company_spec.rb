require 'rails_helper'

describe Company, type: :model do
  let(:company) { create(:company) }

  describe 'Associations' do
    it { is_expected.to have_many(:units).dependent(:destroy) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(company).to be_valid
    end

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }

    it 'is not valid with incorrect phone number' do
      company.phone = '12312'
      expect(company).to_not be_valid

      company.phone = '123144632p'
      expect(company).to_not be_valid
    end

    it 'is valid with blank or correct phone number' do
      company.phone = '0199123122'
      expect(company).to be_valid

      company.phone = nil
      expect(company).to be_valid
    end
  end
end
