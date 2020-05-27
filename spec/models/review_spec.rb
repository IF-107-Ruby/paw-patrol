require 'rails_helper'

RSpec.describe Review, type: :model do
  include_context 'resolved_ticket_and_review'

  describe 'Associations' do
    it { expect(review).to belong_to(:ticket) }
  end

  describe 'Validation' do
    context 'Presence validation' do
      it { expect(review).to validate_presence_of(:rating) }
      it { expect(review).to validate_presence_of(:comment) }
    end

    context 'Inclusion validation' do
      it { expect(review).to validate_inclusion_of(:rating).in_range(1..5) }
    end

    context 'Numericality validation' do
      it { expect(review).to validate_numericality_of(:rating).only_integer }
    end

    context 'Length validation' do
      it { is_expected.to validate_length_of(:comment).is_at_most(255) }
    end

    context 'Uniqueness validation' do
      it { expect(review).to validate_uniqueness_of(:ticket) }
    end

    describe 'Ticket Decision Status' do
      let!(:new_ticket) do
        employee.tickets.create(FactoryBot.attributes_for(:ticket)
                                    .merge(unit: employee.units.first))
      end

      context 'Ticket resolved' do
        before do
          new_ticket.resolved!
        end

        let!(:new_review) { build(:review, ticket: new_ticket) }

        it { expect(new_review).to be_valid }
      end

      context 'Ticket is not resolved' do
        let!(:new_review) { build(:review, ticket: new_ticket) }

        it { expect(new_review).not_to be_valid }
      end
    end
  end
end
