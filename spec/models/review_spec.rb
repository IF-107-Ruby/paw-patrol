require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:ticket) }
  end

  describe 'Validation' do
    context 'Presence validation' do
      it { is_expected.to validate_presence_of(:ticket) }
      it { is_expected.to validate_presence_of(:rating) }
      it { is_expected.to validate_presence_of(:comment) }
    end

    context 'Inclusion validation' do
      it { is_expected.to validate_inclusion_of(:rating).in_range(1..5) }
    end

    context 'Numericality validation' do
      it { is_expected.to validate_numericality_of(:rating).only_integer }
    end

    context 'Length validation' do
      it { is_expected.to validate_length_of(:comment).is_at_most(255) }
    end
  end
end
