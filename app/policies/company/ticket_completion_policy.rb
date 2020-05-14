class Company
  class TicketCompletionPolicy < ApplicationPolicy
    def new?
      user.responsible_for?(record.ticket.unit) && !record.ticket.resolved?
    end

    def create?
      user.responsible_for?(record.ticket.unit) && !record.ticket.resolved?
    end

    class Scope < Scope
      def resolve
        TicketCompletion.where(ticket_id: user.ticket_ids)
      end
    end
  end
end
