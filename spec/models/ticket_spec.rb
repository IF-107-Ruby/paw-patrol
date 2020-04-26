require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    context 'presence validation' do
      it { is_expected.to validate_presence_of(:user) }
      it { is_expected.to validate_presence_of(:name) }
    end

    context 'length validation' do
      it { is_expected.to validate_length_of(:name).is_at_least(6).is_at_most(50) }
    end
  end
end