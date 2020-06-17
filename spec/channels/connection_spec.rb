require 'rails_helper.rb'

RSpec.describe ApplicationCable::Connection, type: :channel do
  let(:user) { create(:user, :with_company) }
  let(:env) { instance_double('env') }

  context 'with a verified user' do
    let(:warden) { instance_double('warden', user: user) }

    before do
      allow_any_instance_of(described_class).to receive(:env).and_return(env)
      allow(env).to receive(:[]).with('warden').and_return(warden)
    end

    it 'successfully connects' do
      expect(connect.current_user.id).to eq user.id
    end
  end

  context 'without a verified user' do
    let(:warden) { instance_double('warden', user: nil) }

    before do
      allow_any_instance_of(described_class).to receive(:env).and_return(env)
      allow(env).to receive(:[]).with('warden').and_return(warden)
    end

    it 'rejects connection' do
      expect { connect '/cable' }.to have_rejected_connection
    end
  end
end
