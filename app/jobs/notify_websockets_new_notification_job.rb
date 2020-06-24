class NotifyWebsocketsNewNotificationJob < ApplicationJob
  queue_as :default

  def perform(notification)
    ActionCable.server.broadcast(
      "notifications:#{notification.user.id}",
      { event: '@newNotification',
        data: notification }
    )
  end
end
