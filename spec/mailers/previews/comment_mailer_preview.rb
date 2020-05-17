# Preview all emails at http://localhost:3000/rails/mailers/comment_mailer
class CommentMailerPreview < ActionMailer::Preview
  def new_comment_email
    ticket = Ticket.all.detect { |t| t.comments.any? }
    comment = ticket.comments.first
    CommentMailer.new_comment_email(comment, ticket)
  end
end
