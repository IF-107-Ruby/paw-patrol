class CommentPolicy < ApplicationPolicy
  def new?
    record.commentable.belongs_to?(user) || user.responsible_for?(record.commentable.unit)
  end

  def create?
    record.commentable.belongs_to?(user) || user.responsible_for?(record.commentable.unit)
  end

  def destroy?
    record.belongs_to?(user)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
