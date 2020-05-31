class CommentMailer < ApplicationMailer
  def new_comment_email(comment, ticket)
    @comment = comment
    @ticket = ticket
    @bcc = @ticket.watchers.pluck(:email)

    mail(bcc: @bcc, subject: 'New comment added')
  end
end
