require 'rails_helper'

RSpec.describe Admin::UserPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  subject { described_class }

  permissions :index? do
    it 'grant access' do
      expect(subject).to permit(admin)
    end

    it 'denied access' do
      expect(subject).not_to permit(user)
    end
  end

  permissions :show? do
    it 'grant access' do
      expect(subject).to permit(admin)
    end

    it 'denied access' do
      expect(subject).not_to permit(user)
    end
  end

  permissions :destroy? do
    it 'grant access' do
      expect(subject).to permit(admin)
    end

    it 'denied access' do
      expect(subject).not_to permit(user)
    end
  end

  permissions :impersonate? do
    it 'grant access' do
      expect(subject).to permit(admin)
    end

    it 'denied access' do
      expect(subject).not_to permit(user)
    end
  end

  permissions :edit? do
    it 'grant access' do
      expect(subject).to permit(admin, admin)
    end

    it 'denied access' do
      expect(subject).not_to permit(admin, user)
    end

    it 'denied access' do
      expect(subject).not_to permit(user, user)
    end
  end

  permissions :update? do
    it 'grant access' do
      expect(subject).to permit(admin, admin)
    end

    it 'denied access' do
      expect(subject).not_to permit(admin, user)
    end

    it 'denied access' do
      expect(subject).not_to permit(user, user)
    end
  end
end
