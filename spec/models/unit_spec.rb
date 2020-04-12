require 'rails_helper'

RSpec.describe Unit, type: :model do
  let(:unit) { create(:unit) }
  describe 'Validation tests' do
    it 'is valid with valid attributes' do
      expect(unit).to be_valid
    end

    it 'is not valid without unit name' do
      unit.name = nil
      expect(unit).to_not be_valid
    end

    it 'is valid without qr_link' do
      unit.qr_link = nil
      expect(unit).to be_valid
    end
  end
end
