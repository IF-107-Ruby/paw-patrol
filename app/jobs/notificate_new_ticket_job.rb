class NotificateNewTicketJob < ApplicationJob
  queue_as :default

  attr_reader :ticket

  delegate :company, :responsible_user, to: :ticket

  def perform(id)
    @ticket = Ticket.find(id)

    send_emails
    broadcast_to_websocket
    return if responsible_user.blank? || responsible_user.telegram_profile.blank?

    notify_telegram
  end

  private

  def send_emails
    if ticket.responsible_user.present?
      TicketMailer.new_ticket_email(ticket)
    else
      TicketMailer.assign_responsible_user_email(ticket)
    end.deliver_now
  end

  def broadcast_to_websocket
    ActionCable.server.broadcast(
      "dashboards_#{company.id}_channel",
      { event: '@newTicket',
        data: ticket.as_json }
    )
  end

  def notify_telegram
    NotifyTelegramNewTicketJob.perform_later(
      responsible_user.telegram_profile.id,
      ticket.id
    )
  end
end
