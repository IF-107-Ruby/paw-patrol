class NotificationDecorator < Draper::Decorator
  delegate_all
  decorates_association :notified_by
  decorates_association :user
end
