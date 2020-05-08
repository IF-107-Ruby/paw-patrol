class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    [first_name, last_name].join(' ').strip
  end

  def display_role
    if admin?
      'Admin'
    else
      role.humanize.capitalize
    end
  end

  def company_name
    company.name
  end
end
