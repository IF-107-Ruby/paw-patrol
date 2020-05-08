class SendConfirmationInstructionsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    unless user.confirmed?
      user.send_confirmation_instructions
    end
  end
end
