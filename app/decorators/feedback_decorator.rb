class FeedbackDecorator < Draper::Decorator
  delegate_all

  include ActionView::Helpers::DateHelper

  def created_time_ago
    "#{time_ago_in_words(created_at)} ago"
  end
end
