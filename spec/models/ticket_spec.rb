require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let(:employee) { create(:employee) }
  let(:company) { create(:company_with_units) }

  before do
    @ticket = create(:ticket, user: employee, unit: company.units.first)
  end

  describe 'Associations' do
    it { expect(@ticket).to belong_to(:user) }
    it { expect(@ticket).to belong_to(:unit) }
  end

  describe 'validations' do
    context 'presence validation' do
      it { expect(@ticket).to validate_presence_of(:user) }
      it { expect(@ticket).to validate_presence_of(:unit) }
      it { expect(@ticket).to validate_presence_of(:name) }
    end

    context 'length validation' do
      it { expect(@ticket).to validate_length_of(:name).is_at_least(6).is_at_most(50) }
    end
  end

  describe 'description' do
    it 'description_attachments' do
      expected = @ticket.description.body.attachments
      expect(@ticket.description_attachments).to eq(expected)
    end
  end
end
