class Company
  class TelegramProfilePolicy < ApplicationPolicy
    def create?
      user.telegram_profile.blank?
    end

    def destroy?
      user.telegram_profile.present?
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
end
