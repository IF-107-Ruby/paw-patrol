class SendInvitationEmailJob < ApplicationJob
  queue_as :default

  def perform(user_id, password)
    user = User.find_by(id: user_id)
    return if user.nil?

    user.password = password
    UserMailer.invitation_email(user).deliver_now
  end
end
