require 'rails_helper'

RSpec.describe Company::TelegramProfilePolicy, type: :policy do
  include_context 'company with users'
  let!(:telegram_profile) { create(:telegram_profile, :with_user, user: staff_member) }

  subject { described_class }

  permissions :create? do
    it 'grant access' do
      expect(subject).to permit(company_owner)
      expect(subject).to permit(employee)
    end

    it 'denied access' do
      expect(subject).not_to permit(staff_member)
    end
  end

  permissions :destroy? do
    it 'grant access' do
      expect(subject).to permit(staff_member)
    end

    it 'denied access' do
      expect(subject).not_to permit(company_owner)
      expect(subject).not_to permit(employee)
    end
  end
end
