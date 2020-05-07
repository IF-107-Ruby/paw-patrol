class CommentPolicy < ApplicationPolicy
  def new?
    true
    # user.ticket_author? || user.responsible_for_unit?
  end

  def create?
    true
    # user.ticket_author? || user.responsible_for_unit?
  end

  def destroy?
    true
    # user.ticket_author? || user.responsible_for_unit?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
