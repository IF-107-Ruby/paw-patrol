class SendConfirmationInstructionsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find_by(id: user_id)
    return if user.nil?

    user.send_confirmation_instructions
  end
end
