require 'rails_helper'

describe Company, type: :model do
  let(:company) { create(:company) }
  
  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(company).to be_valid
    end

    it 'is not valid without a company name' do
      company.name = nil
      expect(company).to_not be_valid
    end

    it 'is not valid without an email' do
      company.email = nil
      expect(company).to_not be_valid
    end
  end
end
