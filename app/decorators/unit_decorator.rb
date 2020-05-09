class UnitDecorator < Draper::Decorator
  delegate_all
  decorates_association :responsible_user

  def creation_headline
    if has_parent?
      "Add new sub unit to #{parent.name}"
    else
      "Add new unit to #{company.name}"
    end
  end
end
