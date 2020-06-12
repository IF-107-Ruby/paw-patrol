class NotifyTelegramNewTicketJob < ApplicationJob
  include Rails.application.routes.url_helpers

  attr_accessor :ticket, :telegram_profile

  queue_as :default

  def perform(ticket_id, telegram_profile_id)
    @ticket = Ticket.find_by({ id: ticket_id }).decorate
    @telegram_profile = TelegramProfile.find(telegram_profile_id).decorate

    NewTicketNotificationHandler.new(telegram_profile, ticket).execute!
  end
end
