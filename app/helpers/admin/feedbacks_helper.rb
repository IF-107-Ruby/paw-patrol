module Admin
  module FeedbacksHelper
    def delete_feedback_link(feedback)
      link_to 'Delete', admin_feedback_path(feedback),
              method: :delete,
              data: { confirm: 'Feedback will be deleted ?' }
    end
  end
end
