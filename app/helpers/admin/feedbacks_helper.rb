module Admin
  module FeedbacksHelper
    def created_time_ago(feedback)
      "#{time_ago_in_words(feedback.created_at)} ago"
    end
  end
end
