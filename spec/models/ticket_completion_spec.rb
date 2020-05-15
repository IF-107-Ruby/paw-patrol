require 'rails_helper'

RSpec.describe TicketCompletion, type: :model do
  include_context 'company with unit, ticket and ticket completion'

  describe 'Associations' do
    it { expect(ticket_completion).to belong_to(:user) }
    it { expect(ticket_completion).to belong_to(:ticket) }
  end

  describe 'validations' do
    context 'presence validation' do
      it { expect(ticket_completion).to validate_presence_of(:user) }
      it { expect(ticket_completion).to validate_presence_of(:ticket) }
    end
  end

  describe 'description' do
    it 'description_attachments' do
      expected = ticket_completion.description.body.attachments
      expect(ticket_completion.description_attachments).to eq(expected)
    end
  end
end
