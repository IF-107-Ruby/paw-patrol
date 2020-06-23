class SendConfirmationInstructionsJob < ApplicationJob
  queue_as :default

  def perform(user)
    user.send_confirmation_instructions
  end
end
