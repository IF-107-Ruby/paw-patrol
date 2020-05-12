class FeedbackDecorator < Draper::Decorator
  delegate_all

  def created_time_ago
    "#{h.time_ago_in_words(created_at)} ago"
  end
end
