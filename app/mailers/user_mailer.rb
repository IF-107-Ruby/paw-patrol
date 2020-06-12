class UserMailer < ApplicationMailer
  def invitation_email(user, password)
    @user = user.decorate
    @login_url = new_user_session_url
    @root_url = root_url
    @password = password
    mail(to: user.email, subject: 'Invitation email')
  end
end
