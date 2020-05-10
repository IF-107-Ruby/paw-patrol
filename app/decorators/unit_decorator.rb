class UnitDecorator < Draper::Decorator
  delegate_all
  decorates_association :responsible_user
  decorates_association :children

  def creation_headline
    if has_parent?
      "Add new sub unit to #{parent.name}"
    else
      "Add new unit to #{company.name}"
    end
  end

  def responsible_user_text
    "#{responsible_user.full_name} is responsible"
  end

  def employees_count
    h.pluralize(users.count, 'employee')
  end
end
