require 'rails_helper'

RSpec.describe WatchersRelationship, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:ticket) }
  end

  describe 'validations' do
    context 'presence validation' do
      it { is_expected.to validate_presence_of(:user) }
      it { is_expected.to validate_presence_of(:ticket) }
    end
  end
end
