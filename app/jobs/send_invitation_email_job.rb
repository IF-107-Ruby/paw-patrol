class SendInvitationEmailJob < ApplicationJob
  queue_as :default

  def perform(user, password)
    user.password = password
    user.send_invitation
  end
end
