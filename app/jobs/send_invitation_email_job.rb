class SendInvitationEmailJob < ApplicationJob
  queue_as :default

  def perform(user_id, password)
    user = User.find_by(id: user_id)
    return if user.nil?

    UserMailer.invitation_email(user, password).deliver_now
  end
end
