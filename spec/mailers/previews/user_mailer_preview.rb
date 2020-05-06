# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def invitation_email
    UserMailer.with(user: User.last).invitation_email
  end
end
