require 'rails_helper'

RSpec.describe RecurringEvent, type: :model do
  let!(:company) { create(:company) }
  let!(:user) { create(:company_owner, company: company) }
  let!(:unit) { create(:unit, company: company) }
  let!(:recurring_event) { create(:recurring_event, user: user, unit: unit) }

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:unit) }
    it { is_expected.to belong_to(:ticket).optional(true) }
  end

  describe 'Validations' do
    describe 'presence validation' do
      it { expect(recurring_event).to validate_presence_of(:user) }
      it { expect(recurring_event).to validate_presence_of(:unit) }
      it { expect(recurring_event).to validate_presence_of(:title) }
      it { expect(recurring_event).to validate_presence_of(:anchor) }
      it { expect(recurring_event).to validate_presence_of(:duration) }
    end

    it 'color validations' do
      expect(recurring_event).to be_valid
      recurring_event.color = '#fffff'
      expect(recurring_event).not_to be_valid
    end

    it 'duration validations' do
      expect(recurring_event).to be_valid
      recurring_event.duration = - 1.day
      expect(recurring_event).not_to be_valid
    end
  end
end
