require 'rails_helper'

RSpec.describe NotifyWebsocketsNewNotificationJob, type: :job do
  include_context 'company with users'
  let!(:unit) do
    create(:unit,
           company: company,
           responsible_user: staff_member,
           users: [employee])
  end
  let!(:ticket) { create(:ticket, unit: unit, user: employee) }
  let!(:comment) { create(:comment, commentable: ticket, user: employee) }
  let(:notification) { staff_member.notifications.last }

  describe '#perform' do
    it 'calls NewTicketNotificationHandler' do
      allow(ActionCable.server).to receive(:broadcast)

      expect(ActionCable.server).to receive(:broadcast)\
        .with("notifications:#{staff_member.id}",
              { event: '@newNotification',
                data: notification })

      described_class.new.perform(notification)
    end
  end
end
