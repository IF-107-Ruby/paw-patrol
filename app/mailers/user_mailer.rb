class UserMailer < ApplicationMailer
  def invitation_email(user)
    @user = user.decorate
    @login_url = new_user_session_url
    @root_url = root_url
    mail(to: user.email)
  end
end
