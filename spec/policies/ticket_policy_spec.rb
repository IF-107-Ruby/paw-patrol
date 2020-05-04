require 'rails_helper'

RSpec.describe TicketPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:employee) { create(:employee) }

  subject { described_class }

  permissions :new? do
    it 'grant access' do
      expect(subject).to permit(employee)
    end

    it 'denied access' do
      expect(subject).not_to permit(user)
    end
  end

  permissions :create? do
    it 'grant access' do
      expect(subject).to permit(employee)
    end

    it 'denied access' do
      expect(subject).not_to permit(user)
    end
  end
end
