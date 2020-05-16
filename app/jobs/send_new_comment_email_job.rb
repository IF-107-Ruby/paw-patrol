class SendNewCommentEmailJob < ApplicationJob
  queue_as :default

  def perform(comment_id, ticket)
    comment = Comment.find_by(id: comment_id)
    return if comment.nil?

    CommentMailer.new_comment_email(comment, ticket).deliver_now
  end
end
