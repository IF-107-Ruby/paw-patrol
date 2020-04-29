require 'rails_helper'

RSpec.describe Feedback, type: :model do
  describe 'Validations' do
    context 'presence validation' do
      it { is_expected.to validate_presence_of(:user_full_name) }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:describe) }
    end

    context 'Length validation' do
      it do
        is_expected.to validate_length_of(:user_full_name)
          .is_at_least(6)
          .is_at_most(50)
      end
      it { is_expected.to validate_length_of(:email).is_at_most(255) }
      it { is_expected.to validate_length_of(:describe).is_at_most(255) }
    end

    context 'Format validation' do
      it { is_expected.to allow_value('test.email@gmail.com').for(:email) }
      it { is_expected.not_to allow_value('not_email.com').for(:email) }
    end
  end
end
