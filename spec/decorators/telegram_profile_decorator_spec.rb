require 'rails_helper'

RSpec.describe TelegramProfileDecorator do
  let(:telegram_profile) { create(:telegram_profile) }
  let(:decorated_telegram_profile) { telegram_profile.decorate }

  it 'telegram_profile#full_name' do
    expect(decorated_telegram_profile.full_name)
      .to eq(telegram_profile.first_name + ' ' + telegram_profile.last_name)
  end
end
