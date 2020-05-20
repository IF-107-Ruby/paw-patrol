class Company
  class TicketCompletionPolicy < ApplicationPolicy
    def create?
      user.responsible_for?(record.ticket.unit) && !record.ticket.resolved?
    end

    def destroy?
      user.completion_performer?(record)
    end

    class Scope < Scope
      def resolve
        TicketCompletion.where(ticket_id: user.ticket_ids)
      end
    end
  end
end
