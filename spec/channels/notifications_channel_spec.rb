require 'rails_helper'

RSpec.describe NotificationsChannel, type: :channel do
  include_context 'company with users'
  let!(:unit) do
    create(:unit,
           company: company,
           responsible_user: staff_member,
           users: [employee])
  end
  let!(:ticket) { create(:ticket, unit: unit, user: employee) }
  let!(:comment) { create(:comment, commentable: ticket, user: employee) }

  describe '#subscribed' do
    it 'successfully subscribes' do
      stub_connection current_user: staff_member

      subscribe
      expect(subscription).to be_confirmed
    end
  end

  describe '#notifications' do
    before do
      stub_connection current_user: staff_member
      subscribe
    end

    it 'broadcasts to current company' do
      perform :notifications

      expect(transmissions.last)
        .to eq({
          event: '@notifications',
          data: staff_member.decorate.unread_notifications
        }.deep_stringify_keys)
    end
  end

  describe '#notifications_read' do
    before do
      stub_connection current_user: staff_member
      subscribe
    end

    it 'broadcasts to current company' do
      perform :notifications_read,
              notification_ids: staff_member.notification_ids

      expect(transmissions.last)
        .to eq({
          event: '@notificationsRead',
          data: staff_member.notifications
        }.deep_stringify_keys)
    end
  end
end
