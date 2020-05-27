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

  describe 'reviewed?' do
    context 'with review' do
      before do
        ticket.resolved!
        create(:review, ticket: ticket)
      end

      it { expect(ticket.reviewed?).to be true }
    end

    context 'without review' do
      it { expect(ticket.reviewed?).to be false }
    end
  end

  describe 'resolution' do
    it 'resolution_attachments' do
      expected = ticket.resolution.body.attachments
      expect(ticket.resolution_attachments).to eq(expected)
    end
  end

  describe 'should have following up ticket' do
    let!(:following_up_ticket) do
      FactoryBot.create(:ticket,
                        :with_following_up_ticket,
                        unit: unit,
                        user: unit.users.last)
    end
    let!(:folloved_up_ticket) { following_up_ticket.parent }

    it 'should have following up ticket' do
      expect(following_up_ticket.parent).not_to be_nil
      expect(following_up_ticket.ancestry).not_to be_nil
      expect(following_up_ticket.children).to be_empty
    end

    it 'should be folloved up ticket' do
      expect(folloved_up_ticket.children).to eq([following_up_ticket])
      expect(folloved_up_ticket.ancestry).to be_nil
      expect(folloved_up_ticket.children).not_to be_empty
    end
  end
end
