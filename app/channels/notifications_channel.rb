class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications:#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end

  def notifications
    transmit(event: '@notifications',
             data: current_user.decorate.unread_notifications)
  end

  def notifications_read(data)
    notifications = current_user.notifications.where(id: data['notification_ids'])
    return unless notifications.update(read: true)

    transmit(event: '@notificationsRead', data: notifications)
  end
end
