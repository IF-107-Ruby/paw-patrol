require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it { should validate_presence_of(:last_name) }

    it { should validate_presence_of(:first_name) }

    it { should validate_presence_of(:email) }
  end
end
