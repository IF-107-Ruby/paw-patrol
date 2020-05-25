require 'rails_helper'

RSpec.describe Ticket, type: :model do
  include_context 'employee with ticket'

  describe 'Associations' do
    it { expect(ticket).to belong_to(:user) }
    it { expect(ticket).to belong_to(:unit) }
    it { expect(ticket).to have_one(:review).dependent(:destroy) }
  end

  describe 'validations' do
    context 'presence validation' do
      it { expect(ticket).to validate_presence_of(:user) }
      it { expect(ticket).to validate_presence_of(:unit) }
      it { expect(ticket).to validate_presence_of(:name) }
    end

    context 'length validation' do
      it { expect(ticket).to validate_length_of(:name).is_at_least(6).is_at_most(50) }
    end
  end

  describe 'description' do
    it 'description_attachments' do
      expected = ticket.description.body.attachments
      expect(ticket.description_attachments).to eq(expected)
    end
  end

  describe 'was_reviewable?' do
    context 'with review' do
      before do
        ticket.resolved!
        create(:review, ticket: ticket)
      end

      it { expect(ticket.was_reviewable?).to be true }
    end

    context 'without review' do
      it { expect(ticket.was_reviewable?).to be false }
    end
  end
end
