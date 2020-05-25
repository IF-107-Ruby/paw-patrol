require 'rails_helper'

RSpec.describe Review, type: :model do
  include_context 'resolved_ticket_and_review'

  describe 'Associations' do
    it { expect(review).to belong_to(:ticket) }
  end

  describe 'Validation' do
    context 'Presence validation' do
      it { expect(review).to validate_presence_of(:ticket) }
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
  end
end
