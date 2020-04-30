class TicketPolicy < ApplicationPolicy
  def new?
    user.employee?
  end

  def create?
    user.employee?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
