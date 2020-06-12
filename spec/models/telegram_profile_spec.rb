require 'rails_helper'

RSpec.describe TelegramProfile, type: :model do
  let!(:telegram_profile) { create(:telegram_profile) }
  let!(:telegram_profile_with_user) { create(:telegram_profile, :with_user) }
  let!(:user) { create(:user) }

  describe 'Associations' do
    it { is_expected.to belong_to(:user).optional(true) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(telegram_profile).to be_valid
    end

    it { should validate_presence_of(:first_name) }
  end

  describe 'start_user_connection' do
    it 'sets and returns connection_token if user not present' do
      expect(telegram_profile.connection_token).to be_nil
      telegram_profile.start_user_connection

      telegram_profile.reload

      expect(telegram_profile.connection_token).not_to be_nil
    end

    it 'doesn\' set connection_token and returns false if user present' do
      expect(telegram_profile_with_user.connection_token).to be_nil
      expect(telegram_profile_with_user.start_user_connection).to be false

      telegram_profile_with_user.reload

      expect(telegram_profile_with_user.connection_token).to be_nil
    end
  end

  describe 'connect_user' do
    it 'sets user and returns true if user not present' do
      expect(telegram_profile.user).to be_nil
      expect(telegram_profile.connect_user(user)).to be true

      telegram_profile.reload

      expect(telegram_profile.user).to eq(user)
    end

    it 'doesn\' set user and returns false if user present' do
      expect(telegram_profile_with_user.user).not_to be_nil
      expect(telegram_profile_with_user.connect_user(user)).to be false

      telegram_profile_with_user.reload

      expect(telegram_profile_with_user.user).not_to eq(user)
    end
  end

  describe 'disconnect_user' do
    it 'removes user and returns true if user present' do
      expect(telegram_profile_with_user.user).not_to be_nil
      expect(telegram_profile_with_user.disconnect_user).to be true

      telegram_profile_with_user.reload

      expect(telegram_profile_with_user.user).to be_nil
    end

    it 'doesn\' remove user and returns false if user not present' do
      expect(telegram_profile.user).to be_nil
      expect(telegram_profile.disconnect_user).to be false
    end
  end
end
