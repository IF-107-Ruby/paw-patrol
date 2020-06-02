require 'rails_helper'

RSpec.describe Event, type: :model do
  let!(:company) { create(:company) }
  let!(:user) { create(:company_owner, company: company) }
  let!(:unit) { create(:unit, company: company) }
  let!(:event) { create(:event, user: user, unit: unit) }

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:unit) }
    it { is_expected.to belong_to(:ticket).optional(true) }
  end

  describe 'Validations' do
    describe 'presence validation' do
      it { expect(event).to validate_presence_of(:user) }
      it { expect(event).to validate_presence_of(:unit) }
      it { expect(event).to validate_presence_of(:title) }
      it { expect(event).to validate_presence_of(:anchor) }
      it { expect(event).to validate_presence_of(:duration) }
    end

    it 'color validations' do
      expect(event).to be_valid
      event.color = '#fffff'
      expect(event).not_to be_valid
    end

    it 'duration validations' do
      expect(event).to be_valid
      event.duration = - 1.day
      expect(event).not_to be_valid
    end
  end
end
