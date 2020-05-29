class Company
  class TicketPolicy < ApplicationPolicy
    def show?
      record.belongs_to?(user) || user.responsible_for?(record.unit)
    end

    def create?
      user.company_owner? || user.employee?
    end

    def resolved?
      create?
    end

    def update?
      record.belongs_to?(user)
    end

    def resolution?
      user.responsible_for?(record.unit)
    end

    def followed_new?
      user.responsible_for?(record.unit)
    end

    class Scope < Scope
      def resolve
        Ticket.where(unit_id: user.company.unit_ids)
      end
    end
  end
end
