class UnitDecorator < Draper::Decorator
  delegate_all
  decorates_association :responsible_user
end
