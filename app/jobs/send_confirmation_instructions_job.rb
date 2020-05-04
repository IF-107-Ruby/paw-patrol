class SendConfirmationInstructionsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    unless user_id.confirmed?
      user_id.send_confirmation_instructions
    end
  end
end
